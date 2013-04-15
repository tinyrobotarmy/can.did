#= require models/calendar_event
#= require collections/calendar_events

describe 'Candid.Collections.CalendarEvents', ->
  events = null

  beforeEach ->
    events = new Candid.Collections.CalendarEvents([{title: "Awesome Event", desription: 'have a great time at this event',start_date: '2012-12-02 12:00:00', end_date: '2012-12-02 14:00:00', location: 'At your house'},{title: "Great Event", desription: 'laugh it up little guy', start_date: '2012-12-03 14:00:00', end_date: '2012-12-02 15:00:00',location: 'At my place'}])

  it 'is a collection of Event models', ->
    events.model.should == Candid.Models.Event

  describe '#forDate', ->
    it 'should filter out events that have are not on the date provided', ->
      events.forDate(new XDate(2012,11,2,12,0,0)).length.should == 1

    it 'should return only events that have a startDate on the date provided', ->
      date = new XDate(2012,11,2,12,0,0)
      events.forDate(date)[0].startDate().getFullYear().should == date.getFullYear()

    it 'should return an empty array if no events start on the date given', ->
      date = new XDate(2012,8,2,12,0,0)
      events.forDate(date).length.should == 0
