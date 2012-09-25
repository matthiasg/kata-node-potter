exports.Potter = class Potter

    SINGLE_BOOK_PRICE = 8

    price: (shoppingCart) ->
        
        totalPrice = 0

        for book in shoppingCart
            totalPrice += SINGLE_BOOK_PRICE

        discount = @calculateDiscount shoppingCart

        return @applyDiscount totalPrice, discount

    calculateDiscount: (shoppingCart) ->

        booksByType = []

        for book in shoppingCart
            if booksByType[book]
                booksByType[book]++ 
            else
                booksByType[book] = 1
        
        numberOfUniqueBooks = 0
        for numberOfBooksOfSpecificType in booksByType
            numberOfUniqueBooks++ if numberOfBooksOfSpecificType>0

        discounts = [1,1,0.95,0.9,0.8,0.75]       

        return discounts[numberOfUniqueBooks]

    applyDiscount: (price, discount) ->
        return price * discount

