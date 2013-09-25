Template.layoutList.layouts = ->
  Layouts.find()

Template.layoutList.events =
  "click .layout-label": -> Session.set("layoutDisplay", @_id)

colorScale = d3.scale.linear()
  .domain([0, 1])
  .range(["red", "green"])

Template.layoutItem.color = -> colorScale(@likelihood)

Template.layout.layoutElements = ->
  Elements.find(layoutId: Session.get("layoutDisplay"))
