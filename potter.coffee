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

    calculateStandardPrice = (books) -> books.length * SINGLE_BOOK_PRICE

    calculateAbsoluteDiscount = (shoppingCart) ->

        absoluteDiscount = 0

        setsOfDistinctBooks = convertShoppingCartIntoSetsOfDistinctBooks shoppingCart

        for s in setsOfDistinctBooks             
            
            discount = DISCOUNTS[s.length]

            undiscountedPriceOfSet = calculateStandardPrice(s)
            absoluteDiscountOnSet = undiscountedPriceOfSet * discount

            absoluteDiscount += absoluteDiscountOnSet

        return absoluteDiscount


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

    applyDiscount = (price, discount) -> return price * discount

