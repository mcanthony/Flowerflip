chai = require 'chai' unless chai
Choice = require '../lib/Choice'
Root = require '../lib/Root'

describe 'Subtrees', ->

  describe 'non-existent attribute lookup in tree', ->
    it 'should return null', (done) ->

      direct = (orig, data) ->
        subtree = orig.tree 'directcalc'
        subtree.deliver data
        t = subtree.then 'tripled', (c, d) ->
          chai.expect(c.get('non-existant1')).to.equal null
          d * 3

      t = Root()
      t.deliver 5
      .all [direct]
      .finally (c, res) ->
        chai.expect(c.get('non-existant2')).to.equal null
        chai.expect(res).to.be.an 'array'
        chai.expect(res).to.eql [
          15
        ]
        done()


  describe 'non-existant attribute lookup in continue tree', ->
    it 'should return null', (done) ->
      direct = (orig, data) ->
        subtree = orig.continue 'directcalc'
        subtree.deliver data
        t = subtree.then 'tripled', (c, d) ->
          chai.expect(c.get('non-existant1')).to.equal null
          d * 3

      t = Root()
      t.deliver 5
      .all [direct]
      .finally (c, res) ->
        chai.expect(c.get('non-existant2')).to.equal null
        chai.expect(res).to.be.an 'array'
        chai.expect(res).to.eql [
          15
        ]
        done()
