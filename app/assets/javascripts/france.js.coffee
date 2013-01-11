jQuery ->
  $(".modal").modal("show")
  paper = Raphael("canvas_france", 450, 480)

  crpvs = {}

  for dep in ["80", "49", "25", "33", "29", "14", "63", "21", "38", "59", "87", "69", "13", "34", "54", "44", "06", "86", "35", "51", "76", "42", "67", "31", "37", "75"]
    departement = departements["departement#{dep}"]
    name = departement.href.dasherize()
    dep_departements = get_dep_departements(dep)
    x = departement.x
    y = departement.y

    crpvs[name] = new Crpv name, dep_departements, x, y, paper

  paper.path("M 432,545.25 L 432,475 L 496.25,433").attr(fill: "none", stroke: "#d6d6d6",transform: "s0.8,0.8,100,100")

#### Functions and classes

class Crpv
  constructor: (@name, @departements, @x, @y, canvas) ->
    @city = @_drawCity(canvas)
    @departements = @_drawDepartements(canvas)

  default_city_attr:
    fill: "black"
    stroke: "white"
    transform: "s0.8,0.8,100,100"

  default_attr:
    stroke: "white"
    transform: "s0.8,0.8,100,100"

  _drawCity: (canvas) ->
    canvas.circle(@x, @y, 4).attr(@default_city_attr)

  _drawDepartements: (canvas) ->
    st = canvas.set()
    for d, departement of @departements
      stroke = if departement.stroke then departement.stroke else @default_attr.stroke
      path = canvas.path(departement.path).attr
        stroke: stroke
        transform: @default_attr.transform
        fill: departement.fill
        cursor: "pointer"
        id: d
      if departement.href?
        path.attr
          href: "/crpvs/#{departement.href.dasherize()}"
      st.push(path)
      city = @city.toFront()
      st.hover(
        ->
          st.stop().animate({fill: "#6666ff"}, 200, "<>")
          city.stop().animate({fill: "#ff6666"}, 200, "<>")
        ,
        ->
          st.stop().animate({fill: "#d6d6d6"}, 200, "<>")
          city.stop().animate({fill: "black"}, 200, "<>"))

_animateDepartements = (canvas, dep, d, current=null) ->
  d.color = "#6666ff"
  d.onmouseover = ->
    d[current].animate({fill: "#f5f5f5", stroke: "#d5d5d5"}, 300) if current
    d.animate({fill: d.color, stroke: "#d5d5d5"}, 300)
    d.toFront()
    canvas.safari()
    current = dep
  d.onmouseout = ->
    d.animate({fill: "#d6d6d6", stroke: "white"}, 300)
    d.toFront()
    canvas.safari()

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
