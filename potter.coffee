assert = require 'assert'
_ = require 'underscore'

exports.Potter = class Potter

    SINGLE_BOOK_PRICE = 8
    DISCOUNTS = [0,0,0.05,0.1,0.2,0.25]      

    price: (shoppingCart) ->
        
        undiscountedPrice = calculateStandardPrice shoppingCart
        absoluteDiscount = calculateAbsoluteDiscount shoppingCart
        
        discountedPrice = undiscountedPrice - absoluteDiscount

        assert.ok discountedPrice > 0 || shoppingCart.length == 0

        return discountedPrice

    calculateStandardPrice = (books) ->

        if books.length
            return books.length * SINGLE_BOOK_PRICE
        else
            return books * SINGLE_BOOK_PRICE
        
    calculateAbsoluteDiscount = (shoppingCart) ->

        absoluteDiscount = 0

        setsOfDistinctBooks = convertShoppingCartIntoSetsOfDistinctBooks shoppingCart

        for s in setsOfDistinctBooks             
            absoluteDiscount += calculateMaximumAvailableDiscountOnSet(s)

        return absoluteDiscount

    calculateMaximumAvailableDiscountOnSet = (set) ->

        possibleDiscounts = []

        for groupSize in [2..5]
            
            groups = splitSetIntoGroups set, groupSize

            discount = DISCOUNTS[groupSize]
            numberOfBooksThatCanBeDiscounted = groups.length * groupSize
           

            undiscountedPriceOfSet = calculateStandardPrice(numberOfBooksThatCanBeDiscounted)        
            absoluteDiscountOnSet = applyDiscount(undiscountedPriceOfSet,discount)

            possibleDiscounts.push absoluteDiscountOnSet

        return _.max(possibleDiscounts)

    splitSetIntoGroups = (set,minimumGroupSize) -> 
        assert.ok minimumGroupSize > 0

        groups = []
        currentGroup = []
        
        for book in set

            currentGroup.push book

            if currentGroup.length == minimumGroupSize
                groups.push currentGroup 
                currentGroup = []   

        for g in groups
            assert.ok g.length == minimumGroupSize

    convertShoppingCartIntoSetsOfDistinctBooks = (shoppingCart) ->
        # IN:  [0,0,0,1,1,1,5,4]
        # OUT: [0,1,5,4],[0,1],[0,1]
        sets = []

        for book in shoppingCart

            setThatDoesNotHaveTheCurrentBookType = _.find sets, (s)-> _.all(s, (b) -> b != book)

            if not setThatDoesNotHaveTheCurrentBookType 
                setThatDoesNotHaveTheCurrentBookType = []
                sets.push setThatDoesNotHaveTheCurrentBookType

            setThatDoesNotHaveTheCurrentBookType.push book

        for s in sets
            assert.equal( s.length, _.uniq(s).length )
        
        return sets

    applyDiscount = (price, discount) -> return floor( price * discount, 4 )

    floor = (num, dec) -> Math.floor(num*Math.pow(10,dec))/Math.pow(10,dec)

