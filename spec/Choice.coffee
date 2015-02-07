chai = require 'chai' unless chai
Choice = require '../lib/Choice'

describe 'Choice node API', ->
  describe 'with no parents', ->
    it 'should not provide items if it has not been initialized with any', (done) ->
      validated = false
      c = new Choice
      item = c.getItem (i) -> validated = true
      chai.expect(item).to.be.a 'null'
      chai.expect(validated).to.equal false
      done()

    it 'should call validation callback for the item in array', (done) ->
      validated = false
      providedItem =
        id: 'foo'
      c = new Choice
      c.items.push providedItem
      item = c.getItem (i) ->
        validated = true if i is providedItem
      chai.expect(item).to.equal providedItem
      chai.expect(validated).to.equal true
      done()

    it 'should not return an item once it has been eaten', (done) ->
      providedItem =
        id: 'foo'
      c = new Choice
      c.items.push providedItem
      chai.expect(c.availableItems().length).to.equal 1
      item = c.getItem (i) -> true
      chai.expect(item).to.equal providedItem

      c.eatItem item
      chai.expect(c.availableItems().length).to.equal 0
      nextItem = c.getItem (i) -> true
      chai.expect(nextItem).to.be.a 'null'
      done()

  describe 'with a parent', ->
    it 'should not provide items if it has not been initialized with any', (done) ->
      validated = false
      p = new Choice
      c = new Choice p
      item = c.getItem (i) -> validated = true
      chai.expect(item).to.be.a 'null'
      chai.expect(validated).to.equal false
      done()

    it 'should call validation callback for the item in array', (done) ->
      providedItem =
        id: 'foo'
      p = new Choice
      p.items.push providedItem
      validated = false
      c = new Choice p
      item = c.getItem (i) ->
        validated = true if i is providedItem
      chai.expect(item).to.equal providedItem
      chai.expect(validated).to.equal true
      done()

    it 'should not return an item once it has been eaten', (done) ->
      providedItem =
        id: 'foo'
      p = new Choice
      p.items.push providedItem
      c = new Choice p
      chai.expect(c.availableItems().length).to.equal 1
      item = c.getItem (i) -> true
      chai.expect(item).to.equal providedItem

      c.eatItem item
      chai.expect(c.availableItems().length).to.equal 0
      nextItem = c.getItem (i) -> true
      chai.expect(nextItem).to.be.a 'null'
      done()