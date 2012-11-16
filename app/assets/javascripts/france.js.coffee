jQuery ->
  paper = Raphael("canvas_france", 450, 480)

  default_attr =
    stroke: "white"
    transform: "s0.8,0.8,100,100"

  for name, departement of departements
    stroke = if departement.stroke then departement.stroke else default_attr.stroke
    france_path = paper.path(departement.path).attr
      stroke: stroke
      transform: default_attr.transform
      fill: departement.fill
