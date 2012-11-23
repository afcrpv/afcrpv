jQuery ->
  paper = Raphael("canvas_france", 450, 480)

  default_attr =
    stroke: "white"
    transform: "s0.8,0.8,100,100"

  france_path = {}
  for name, departement of departements
    stroke = if departement.stroke then departement.stroke else default_attr.stroke
    france_path[name] = paper.path(departement.path).attr
      stroke: stroke
      transform: default_attr.transform
      fill: departement.fill
      cursor: "pointer"

  current = null
  for d, dep of france_path
    dep.color = "#6666ff"
    animate_departements(paper, france_path[dep], dep) unless d is "corsica_line"

animate_departements = (paper, dep, d) ->
  d[0].onmouseover = ->
    current && d[current].animate({fill: "#f5f5f5", stroke: "#d5d5d5"}, 300)
    d.animate({fill: d.color, stroke: "#d5d5d5"}, 300)
    d.toFront()
    paper.safari()
    current = dep
  d[0].onmouseout = ->
    d.animate({fill: "#d6d6d6", stroke: "white"}, 300)
    d.toFront()
    paper.safari()
