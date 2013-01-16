jQuery ->
  paper = Raphael("canvas_france", 450,460)

  paper.setStart()

  for dep in ["80", "49", "25", "33", "29", "14", "63", "21", "38", "59", "87", "69", "13", "34", "54", "44", "06", "86", "35", "51", "76", "42", "67", "31", "37", "75"]
    departement = departements["departement#{dep}"]
    name = departement.href
    href = name.dasherize()
    dep_departements = get_dep_departements(dep)
    x = departement.x
    y = departement.y
    lx = if departement.lx then departement.lx else x
    ly = if departement.ly then departement.ly else y

    new Crpv name, href, dep_departements, x, y, ly, paper

  corsica_line = paper.path("M 432,545.25 L 432,475 L 496.25,433").attr(fill: "none", stroke: "#d6d6d6").toBack()
  dom_line = paper.path("M 10,188 L 80,220 L 80,420").attr(fill: "none", stroke: "#d6d6d6").toBack()

  st = paper.setFinish()

  translate = 't'+(-1*st.getBBox().x)+','+(-1*st.getBBox().y)
  st.transform(translate)
  st.transform('s0.84,0.84,0,0')

#### Functions and classes

class Crpv
  constructor: (@name, @href, @departements, @x, @y, @ly, canvas) ->
    @city = @_drawCity(canvas)
    @label = @_drawLabel(canvas)
    @path_departements = @_drawDepartements(canvas)

  default_city_attr:
    fill: "black"
    stroke: "white"

  default_attr:
    stroke: "white"

  _drawCity: (canvas) ->
    canvas.circle(@x, @y, 4).attr(@default_city_attr).attr(href: "/crpvs/#{@href}")

  _drawLabel: (canvas) ->
    canvas.text(@x,@ly,@name.titleize()).attr("font-size": 14, "font-weight": "bold").hide()

  _drawDepartements: (canvas) ->
    deps_set = canvas.set()
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
          href: "/crpvs/#{@href}"
      if departement.dom_label?
        dom_label = canvas.text(departement.dom_label.x, departement.dom_label.y, departement.name.titleize()).attr("font-size": 11, "font-weight": "bold").toFront()

      deps_set.push(path)

    city = @city.toFront()
    label = @label.toFront()
    new_st = canvas.set()
    new_st.push(city, label, deps_set)
    new_st.hover(_hoverIn(deps_set, city, label, "#8888ff", "#ff6666"), _hoverOut(deps_set, city, label, "#d6d6d6", "black"))

_hoverIn = (node, city, label, dep_color_in, city_color_in) ->
  ->
    node.stop().animate({fill: dep_color_in}, 200, "<>")
    city.stop().animate({fill: city_color_in}, 200, "<>")
    label.show().toFront()

_hoverOut = (node, city, label, dep_color_out, city_color_out) ->
  ->
    node.stop().animate({fill: dep_color_out}, 200, "<>")
    city.stop().animate({fill: city_color_out}, 200, "<>")
    label.hide()

String::dasherize = ->
  @replace(/\s/g, "-").toLowerCase()

String::titleize = ->
 @charAt(0).toUpperCase() + @substr(1)

get_dep_departements = (cp) ->
  # get target name
  target_name = departements["departement#{cp}"].href
  results = {}
  # cycle departements hash
  for d, departement of departements
    # populate results hash with departement.path if departement.href is == target_name
    if departement.href is target_name
      results[d] =
        name: departement.name
        path: departement.path
        fill: if departement.fill then departement.fill else "#d6d6d6"
        stroke: if departement.stroke then departement.stroke else "white"
        href: if departement.href then departement.href else null
        subhref: if departement.subhref then departement.subhref else null
        dom_label: if departement.dom_label then departement.dom_label else null

  return results
