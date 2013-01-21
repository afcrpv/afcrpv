#encoding: utf-8
(Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales : [:fr]).each do |lang|
  I18n.locale = lang

  if defined?(Refinery::User)
    Refinery::User.all.each do |user|
      if user.plugins.where(:name => 'refinerycms-crpvs').blank?
        user.plugins.create(:name => 'refinerycms-crpvs',
                            :position => (user.plugins.maximum(:position) || -1) +1)
      end
    end
  end

  url = "/crpvs"
  if defined?(Refinery::Page) && Refinery::Page.where(:link_url => url).empty?
    page = Refinery::Page.create(
      :title => 'Crpvs',
      :link_url => url,
      :deletable => false,
      :menu_match => "^#{url}(\/|\/.+?|)$"
    )
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      page.parts.create(:title => default_page_part, :body => nil, :position => index)
    end
  end
end

#seed refinery_crpvs table
require 'yaml'
departements = Psych.load( <<EOY )
- cp: "01"
  name: Ain
- cp: "02"
  name: Aisne
- cp: "03"
  name: Allier
- cp: "04"
  name: Alpes-de-Haute-Provence
- cp: "05"
  name: Hautes-Alpes
- cp: "06"
  name: Alpes-Maritimes
- cp: "07"
  name: Ardèche
- cp: "08"
  name: Ardennes
- cp: "09"
  name: Ariège
- cp: 10
  name: Aube
- cp: 11
  name: Aude
- cp: 12
  name: Aveyron
- cp: 13
  name: Bouches-du-Rhône
- cp: 14
  name: Calvados
- cp: 15
  name: Cantal
- cp: 16
  name: Charente
- cp: 17
  name: Charente-Maritime
- cp: 18
  name: Cher
- cp: 19
  name: Corrèze
- cp: 20
  name: Corse
- cp: 21
  name: Côte-d'Or
- cp: 22
  name: Côtes d'Armor
- cp: 23
  name: Creuse
- cp: 24
  name: Dordogne
- cp: 25
  name: Doubs
- cp: 26
  name: Drôme
- cp: 27
  name: Eure
- cp: 28
  name: Eure-et-Loir
- cp: 29
  name: Finistère
- cp: 30
  name: Gard
- cp: 31
  name: Haute-Garonne
- cp: 32
  name: Gers
- cp: 33
  name: Gironde
- cp: 34
  name: Hérault
- cp: 35
  name: Ille-et-Vilaine
- cp: 36
  name: Indre
- cp: 37
  name: Indre-et-Loire
- cp: 38
  name: Isère
- cp: 39
  name: Jura
- cp: 40
  name: Landes
- cp: 41
  name: Loir-et-Cher
- cp: 42
  name: Loire
- cp: 43
  name: Haute-Loire
- cp: 44
  name: Loire-Atlantique
- cp: 45
  name: Loiret
- cp: 46
  name: Lot
- cp: 47
  name: Lot-et-Garonne
- cp: 48
  name: Lozère
- cp: 49
  name: Maine-et-Loire
- cp: 50
  name: Manche
- cp: 51
  name: Marne
- cp: 52
  name: Haute-Marne
- cp: 53
  name: Mayenne
- cp: 54
  name: Meurthe-et-Moselle
- cp: 55
  name: Meuse
- cp: 56
  name: Morbihan
- cp: 57
  name: Moselle
- cp: 58
  name: Nièvre
- cp: 59
  name: Nord
- cp: 60
  name: Oise
- cp: 61
  name: Orne
- cp: 62
  name: Pas-de-Calais
- cp: 63
  name: Puy-de-Dôme
- cp: 64
  name: Pyrénées-Atlantiques
- cp: 65
  name: Hautes-Pyrénées
- cp: 66
  name: Pyrénées-Orientales
- cp: 67
  name: Bas-Rhin
- cp: 68
  name: Haut-Rhin
- cp: 69
  name: Rhône
- cp: 70
  name: Haute-Saône
- cp: 71
  name: Saône-et-Loire
- cp: 72
  name: Sarthe
- cp: 73
  name: Savoie
- cp: 74
  name: Haute-Savoie
- cp: 75
  name: Paris
- cp: 76
  name: Seine-Maritime
- cp: 77
  name: Seine-et-Marne
- cp: 78
  name: Yvelines
- cp: 79
  name: Deux-Sèvres
- cp: 80
  name: Somme
- cp: 81
  name: Tarn
- cp: 82
  name: Tarn-et-Garonne
- cp: 83
  name: Var
- cp: 84
  name: Vaucluse
- cp: 85
  name: Vendée
- cp: 86
  name: Vienne
- cp: 87
  name: Haute-Vienne
- cp: 88
  name: Vosges
- cp: 89
  name: Yonne
- cp: 90
  name: Territoire de Belfort
- cp: 91
  name: Essonne
- cp: 92
  name: Hauts-de-Seine
- cp: 93
  name: Seine-St-Denis
- cp: 94
  name: Val-de-Marne
- cp: 95
  name: Val-D'Oise
- cp: 971
  name: Guadeloupe
- cp: 972
  name: Martinique
- cp: 973
  name: Guyane
- cp: 974
  name: Réunion
- cp: 975
  name: Saint-Pierre-et-Miquelon
- cp: 976
  name: Mayotte
- cp: 986
  name: Wallis-et-Futuna
- cp: 987
  name: Polynésie française
- cp: 988
  name: Nouvelle-Calédonie
EOY

departements.each do |departement|
  puts "processing departement #{departement["name"]}"
  Departement.find_or_create_by_name(departement["name"], cp: departement["cp"])
end

crpvs = Psych.load( <<EOY )
- name: Amiens
  departements:
    - "02"
    - "60"
    - "80"
- name: Angers
  departements:
    - "49"
    - "53"
    - "72"
- name: Besançon
  departements:
    - "25"
    - "39"
    - "70"
    - "90"
- name: Bordeaux
  departements:
    - "24"
    - "33"
    - "40"
    - "47"
    - "64"
    - "971"
    - "972"
    - "973"
    - "974"
- name: Brest
  departements:
    - "29"
    - "56"
- name: Caen
  departements:
    - "14"
    - "50"
    - "61"
- name: Clermont-Ferrand
  departements:
    - "03"
    - "15"
    - "43"
    - "63"
- name: Créteil
  departements:
    - "77"
    - "94"
- name: Dijon
  departements:
    - "21"
    - "58"
    - "71"
    - "89"
- name: Grenoble
  departements:
    - "38"
- name: Lille
  departements:
    - "59"
    - "62"
- name: Limoges
  departements:
    - "19"
    - "23"
    - "36"
    - "87"
- name: Lyon
  departements:
    - "1"
    - "07"
    - "26"
    - "69"
    - "73"
    - "74"
- name: Marseille
  departements:
    - "04"
    - "13"
    - "84"
    - "2A"
    - "2B"
- name: Montpellier
  departements:
    - "11"
    - "30"
    - "34"
    - "48"
    - "66"
- name: Nancy
  departements:
    - "54"
    - "55"
    - "57"
    - "88"
- name: Nantes
  departements:
    - "44"
    - "85"
- name: Nice
  departements:
    - "06"
    - "05"
    - "83"
- name: Paris-Pitié-Salpêtrière
  departements:
    - "28"
  arrondissements:
    - 5
    - 8
    - 13
- name: Paris-Georges Pompidou
  departements:
    - "92"
  arrondissements:
    - 1
    - 14
    - 15
    - 16
- name: Paris-Saint-Antoine
  departements:
    - "93"
  arrondissements:
    - 3
    - 4
    - 11
    - 12
    - 20
- name: Paris-Cochin-St Vincent de Paul
  departements:
    - "91"
  arrondissements:
    - 6
    - 7
- name: Paris-Fernand Widal
  departements:
    - "78"
    - "95"
  arrondissements:
    - 2
    - 9
    - 10
    - 17
    - 18
    - 19
- name: Poitiers
  departements:
    - "16"
    - "17"
    - "79"
    - "86"
- name: Reims
  departements:
    - "8"
    - "10"
    - "51"
    - "52"
- name: Rennes
  departements:
    - "22"
    - "35"
- name: Rouen
  departements:
    - "27"
    - "76"
- name: Saint-Etienne
  departements:
    - "42"
- name: Strasbourg
  departements:
    - "67"
    - "68"
- name: Toulouse
  departements:
    - "09"
    - "12"
    - "31"
    - "32"
    - "46"
    - "65"
    - "81"
    - "82"
- name: Tours
  departements:
    - "18"
    - "37"
    - "41"
    - "45"
EOY

crpvs.each do |crpv|
  puts "processing crpv #{crpv["name"]}"
  new_crpv = Refinery::Crpvs::Crpv.find_or_create_by_name(crpv["name"])
  puts "assigning departements"
  new_crpv.departements = Departement.where(cp: crpv["departements"]).all
end
