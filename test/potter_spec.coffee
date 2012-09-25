expect = require('chai').expect

Potter = require('../potter').Potter
potter = new Potter


describe 'kata-potter', ->

    describe 'basic scenarios', ->
    
        it 'should cost 0 when a shopping cart is empty', ->
            expect(potter.price []).to.equal 0        

        it 'should cost 8 for a single book of type 0', ->
            expect(potter.price [0]).to.equal 8
        

        it 'should cost 8 for a single book of type 1', ->
            expect(potter.price [1]).to.equal 8

        it 'should cost 8 for a single book of type 2', ->
            expect(potter.price [2]).to.equal 8

        it 'should cost 8 for a single book of type 3', ->
            expect(potter.price [3]).to.equal 8

        it 'should cost 8 for a single book of type 4', ->
            expect(potter.price [4]).to.equal 8

        it 'should cost 16 for two books of the same kind', ->
            expect(potter.price [0, 0]).to.equal 8 * 2

        it 'should cost 24 for three books of the same kind', ->
            expect(potter.price [1, 1, 1]).to.equal 8 * 3

    describe 'simple discounts', ->    

        it 'should apply a discount when buying 2 books of different types', ->
            expect(potter.price [0, 1]).to.equal 8 * 2 * 0.95

        it 'should apply a discount when buying 3 books of different types', ->
            expect(potter.price [0, 2, 4]).to.equal 8 * 3 * 0.9

        it 'should apply a discount when buying 4 books of different types', ->
            expect(potter.price [0, 1, 2, 4]).to.equal 8 * 4 * 0.8

        it 'should apply a discount when buying 5 books of different types', ->
            expect(potter.price [0, 1, 2, 3, 4]).to.equal 8 * 5 * 0.75

    describe 'testSeveralDiscounts', ->
        it 'should apply correct discount for two pairs of different books', ->
            expect(potter.price [0, 0, 1, 1]).to.equal 2 * (8 * 2 * 0.95)
        it 'should apply correct discount for two different books with one extra', ->
            expect(potter.price [0, 0, 1]).to.equal 8 + (8 * 2 * 0.95)
        it 'should apply correct discount for group of four diffent books and another group of two different books ', ->
            expect(potter.price [0, 0, 1, 2, 2, 3]).to.equal((8 * 4 * 0.8) + (8 * 2 * 0.95))
        it 'should apply correct discount', ->
            expect(potter.price [0, 1, 1, 2, 3, 4]).to.equal 8 + (8 * 5 * 0.75)

    describe 'testEdgeCases', ->
        #expect(potter.price [0, 0, 1, 1, 2, 2, 3, 4]).to.equal 2 * (8 * 4 * 0.8)
        #expect(potter.price [0, 0, 0, 0, 0, 1, 1, 1, 1, 1,2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4]).to.equal(3 * (8 * 5 * 0.75) + 2 * (8 * 4 * 0.8))
###