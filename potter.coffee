exports.Potter = class Potter

    SINGLE_BOOK_PRICE = 8

    price: (shoppingCart) ->
        
        totalPrice = 0

        for book in shoppingCart
            totalPrice += SINGLE_BOOK_PRICE

        return totalPrice

