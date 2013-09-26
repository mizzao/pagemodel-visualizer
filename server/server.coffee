Meteor.startup ->
  Layouts._ensureIndex
    idx: 1

  Elements._ensureIndex
    layoutId: 1

Meteor.publish "stuff", ->
    [Layouts.find(), Elements.find()]

Meteor.methods
  "setLayout": (idx, layout, elements) ->
    unless layout = Layouts.findOne(idx: idx)
      layoutId = Layouts.insert(idx: idx)
    else
      layoutId = layout._id

    # update layout properties
    Layouts.update(layoutId, $set: layout)

    # Delete all old elements on this layout
    Elements.remove {layoutId: layoutId}, {multi: true}
    _.each elements, (element) ->
      Elements.insert _.extend {layoutId}, element

  "log": ->
    console.log arguments
