#= require models/calendar_event

describe 'Candid.Models.CalendarEvent', ->
  calendar_event = null

  beforeEach ->
    calendar_event = new Candid.Models.CalendarEvent(title: "Awesome Event", desription: 'have a great time at this calendar_event',start_date: '2012-12-02 12:00:00', end_date: '2012-12-02 14:00:00', location: 'At your house')

  describe '#startDate', ->
    it 'should return an XDate representation of the start_date attribute', ->
      expect(calendar_event.startDate()).toEqual(new XDate(2012,11,2,12,0,0))

  describe '#endDate', ->
    it 'should return an XDate representation of the start_date attribute', ->
      expect(calendar_event.endDate()).toEqual(new XDate(2012,11,2,14,0,0))

  describe '#durationInHours', ->
    it 'should return the duration of the calendar_event in hours', ->
      expect(calendar_event.durationInHours()).toEqual(2)
