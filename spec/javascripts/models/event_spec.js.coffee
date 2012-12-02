#= require models/event

describe 'Candid.Models.Event', ->
  event = null

  beforeEach ->
    event = new Candid.Models.Event(title: "Awesome Event", desription: 'have a great time at this event',start_date: '2012-12-02 12:00:00', end_date: '2012-12-02 14:00:00', location: 'At your house')

  describe '#startDate', ->
    it 'should return an XDate representation of the start_date attribute', ->
      event.startDate().should == new XDate(2012,11,2,12,0,0)
