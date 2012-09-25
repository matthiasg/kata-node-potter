expect = require('chai').expect

Potter = require('../potter').Potter
potter = new Potter


describe 'jasmine-node', ->

    it 'testBasics', ->
        expect(potter.price []).to.equal 0
        
        expect(potter.price [0]).to.equal 8
        expect(potter.price [1]).to.equal 8
        expect(potter.price [2]).to.equal 8
        expect(potter.price [3]).to.equal 8
        expect(potter.price [4]).to.equal 8

        expect(potter.price [0, 0]).to.equal 8 * 2
        expect(potter.price [1, 1, 1]).to.equal 8 * 3

    it 'testSimpleDiscounts', ->
        expect(potter.price [0, 1]).to.equal 8 * 2 * 0.95
        expect(potter.price [0, 2, 4]).to.equal 8 * 3 * 0.9
        expect(potter.price [0, 1, 2, 4]).to.equal 8 * 4 * 0.8
        expect(potter.price [0, 1, 2, 3, 4]).to.equal 8 * 5 * 0.75

    it 'testSeveralDiscounts', ->
        #expect(potter.price [0, 0, 1]).to.equal 8 + (8 * 2 * 0.95)
        #expect(potter.price [0, 0, 1, 1]).to.equal 2 * (8 * 2 * 0.95)
        #expect(potter.price [0, 0, 1, 2, 2, 3]).to.equal((8 * 4 * 0.8) + (8 * 2 * 0.95))
        #expect(potter.price [0, 1, 1, 2, 3, 4]).to.equal 8 + (8 * 5 * 0.75)

    it 'testEdgeCases', ->
        #expect(potter.price [0, 0, 1, 1, 2, 2, 3, 4]).to.equal 2 * (8 * 4 * 0.8)
        #expect(potter.price [0, 0, 0, 0, 0, 1, 1, 1, 1, 1,2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4]).to.equal(3 * (8 * 5 * 0.75) + 2 * (8 * 4 * 0.8))
