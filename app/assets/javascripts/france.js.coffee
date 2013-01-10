jQuery ->
  $(".modal").modal("show")

  crpvs = {}

  for dep in ["80", "49", "25", "33", "29", "14", "63", "94", "21", "38", "59", "87", "69", "13", "34", "54", "44", "06", "86", "35", "51", "76", "42", "67", "31", "37", "75"]
    departement = departements["departement#{dep}"]
    name = departement.href.dasherize()
    dep_departements = get_dep_departements(dep)
    x = departement.x
    y = departement.y

    crpvs[name] = new Crpv name, dep_departements, x, y

  paper = Raphael("canvas_france", 450, 480)


  for d, dep of departements
    console.log d if dep.href is null

  #current = null
  #for d, dep of france_path
    #dep.color = "#6666ff"
    #animate_departements(paper, france_path[dep], dep) unless d is "corsica_line"

  for c, crpv of crpvs
    crpv._drawDepartements(paper)
    crpv._drawCity(paper)

  paper.path("M 432,545.25 L 432,475 L 496.25,433").attr(fill: "none", stroke: "#d6d6d6",transform: "s0.8,0.8,100,100")

#### Functions and classes

class Crpv
  constructor: (@name, @departements, @x, @y) ->

  default_city_attr:
    fill: "black"
    stroke: "black"
    transform: "s0.8,0.8,100,100"

  default_attr:
    stroke: "white"
    transform: "s0.8,0.8,100,100"

  _drawCity: (canvas) ->
    canvas.circle(@x, @y, 4).attr(@default_city_attr)

  _drawDepartements: (canvas) ->
    for d, departement of @departements
      stroke = if departement.stroke then departement.stroke else @default_attr.stroke
      path = canvas.path(departement.path).attr
        stroke: stroke
        transform: @default_attr.transform
        fill: departement.fill
        cursor: "pointer"
      if departement.href?
        path.attr
          href: "/crpvs/#{departement.href.dasherize()}"


String::dasherize = ->
  @replace(/\s/g, "-").toLowerCase()

get_dep_departements = (cp) ->
  # get target name
  target_name = departements["departement#{cp}"].href
  results = {}
  # cycle departements hash
  for d, departement of departements
    # populate results hash with departement.path if departement.href is == target_name
    if departement.href is target_name
      results[d] =
        path: departement.path
        fill: if departement.fill then departement.fill else "#d6d6d6"
        stroke: if departement.stroke then departement.stroke else "white"
        href: if departement.href then departement.href else null
        subhref: if departement.subhref then departement.subhref else null

  return results

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
