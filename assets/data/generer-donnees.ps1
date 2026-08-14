# Génération déterministe du jeu de données AltiSport (graine 20260814)
# Sortie : assets/data/brut/*.csv — UTF-8 BOM, séparateur ';', décimales virgule
$ErrorActionPreference = 'Stop'
$outDir = Join-Path $PSScriptRoot 'brut'
New-Item -ItemType Directory -Path $outDir -Force | Out-Null
$rnd = [System.Random]::new(20260814)
$fr  = [System.Globalization.CultureInfo]::GetCultureInfo('fr-FR')
function Num([double]$v) { return ([math]::Round($v, 2)).ToString('0.00', $fr) }
function Fd([datetime]$d) { return $d.ToString('dd/MM/yyyy') }
function PickW([array]$vals, [array]$ws) {
  $tot = 0.0; foreach ($w in $ws) { $tot += $w }
  $r = $rnd.NextDouble() * $tot; $c = 0.0
  for ($i = 0; $i -lt $vals.Count; $i++) { $c += $ws[$i]; if ($r -lt $c) { return $vals[$i] } }
  return $vals[-1]
}

# ---------- PRODUITS ----------
$catDef = @(
  @{Cd='SKI'; Lbl='Ski';         N=14; Min=250; Max=1200; Sb=@('Skis alpins','Skis de fond','Fixations','Chaussures ski')},
  @{Cd='SNB'; Lbl='Snowboard';   N=10; Min=200; Max=900;  Sb=@('Planches','Boots','Fixations SB')},
  @{Cd='RAN'; Lbl='Randonnée';   N=14; Min=40;  Max=350;  Sb=@('Chaussures rando','Bâtons','Sacs à dos','Vêtements rando')},
  @{Cd='VEL'; Lbl='Cyclisme';    N=12; Min=60;  Max=2500; Sb=@('VTT','Vélo de route','Casques','Accessoires vélo')},
  @{Cd='ACC'; Lbl='Divers';      N=14; Min=10;  Max=160;  Sb=@('Lunettes','Gants','Casquettes','Entretien')}
)
$brands = @('AltiPro','Vertigo','NordX','PeakLine','OraFlex')
$produits   = New-Object System.Collections.Generic.List[object]
$prodsByCat = @{}
$prodById   = @{}
$pidx = 1
foreach ($c in $catDef) {
  $prodsByCat[$c.Cd] = New-Object System.Collections.Generic.List[object]
  for ($i = 0; $i -lt $c.N; $i++) {
    $pu  = 5 * [math]::Round(($c.Min + $rnd.NextDouble() * ($c.Max - $c.Min)) / 5)
    $cst = [math]::Round($pu * (0.45 + $rnd.NextDouble() * 0.17), 2)
    $sb  = $c.Sb[$rnd.Next($c.Sb.Count)]
    $m   = $brands[$rnd.Next($brands.Count)]
    $p = [pscustomobject]@{
      ProdID = ('P{0:D4}' -f $pidx); PrdLbl = "$m $sb M$($rnd.Next(100,999))"
      CatCd = $c.Cd; CatLbl = $c.Lbl; SbCat = $sb; Marque = $m
      PU = [double]$pu; CstA = $cst
    }
    $produits.Add($p); $prodsByCat[$c.Cd].Add($p); $prodById[$p.ProdID] = $p; $pidx++
  }
}
$produits | Select-Object ProdID, PrdLbl, CatCd, CatLbl, SbCat, Marque,
  @{n='PU_TTC'; e={ Num $_.PU }}, @{n='CstA'; e={ Num $_.CstA }} |
  Export-Csv (Join-Path $outDir 'produits.csv') -NoTypeInformation -Delimiter ';' -Encoding utf8BOM

# ---------- MAGASINS ----------
$storesDef = @(
  @{V='Lille'; D='59'; S='Nord-Ouest'}, @{V='Rouen'; D='76'; S='Nord-Ouest'},
  @{V='Rennes'; D='35'; S='Nord-Ouest'}, @{V='Nantes'; D='44'; S='Nord-Ouest'},
  @{V='Strasbourg'; D='67'; S='Nord-Est'}, @{V='Reims'; D='51'; S='Nord-Est'},
  @{V='Metz'; D='57'; S='Nord-Est'}, @{V='Nancy'; D='54'; S='Nord-Est'},
  @{V='Dijon'; D='21'; S='Nord-Est'},
  @{V='Paris Bastille'; D='75'; S='Île-de-France'}, @{V='Paris Nation'; D='75'; S='Île-de-France'},
  @{V='Annecy'; D='74'; S='Sud-Est'}, @{V='Chamonix'; D='74'; S='Sud-Est'},
  @{V='Grenoble'; D='38'; S='Sud-Est'}, @{V='Lyon'; D='69'; S='Sud-Est'},
  @{V='Nice'; D='06'; S='Sud-Est'}, @{V='Marseille'; D='13'; S='Sud-Est'},
  @{V='Clermont-Ferrand'; D='63'; S='Sud-Est'},
  @{V='Toulouse'; D='31'; S='Sud-Ouest'}, @{V='Bordeaux'; D='33'; S='Sud-Ouest'},
  @{V='Montpellier'; D='34'; S='Sud-Ouest'}, @{V='Bayonne'; D='64'; S='Sud-Ouest'},
  @{V='Pau'; D='64'; S='Sud-Ouest'}, @{V='Limoges'; D='87'; S='Sud-Ouest'},
  @{V='Tours'; D='37'; S='Sud-Ouest'}
)
$magasins = New-Object System.Collections.Generic.List[object]
for ($i = 0; $i -lt $storesDef.Count; $i++) {
  $s = $storesDef[$i]
  $magasins.Add([pscustomobject]@{
    MagID = ('M{0:D2}' -f ($i + 1)); MagLbl = "AltiSport $($s.V)"
    Ville = ($s.V -replace ' .*', ''); DeptCd = $s.D; Secteur = $s.S
    SurfM2 = (200 + 50 * $rnd.Next(1, 14))
    DtOuvert = Fd ([datetime]::new(2012, 1, 1).AddDays($rnd.Next(0, 3650)))
  })
}
$magasins | Export-Csv (Join-Path $outDir 'magasins.csv') -NoTypeInformation -Delimiter ';' -Encoding utf8BOM

# ---------- VENDEURS ----------
$fn = @('Jean','Claire','Marie','Thomas','Léa','Nicolas','Sophie','Julien','Camille','Antoine','Émilie','Lucas','Chloé','Maxime','Manon','Hugo','Julie','Pierre','Laura','Rémi')
$ln = @('MARTIN','BERNARD','DUBOIS','ROBERT','RICHARD','PETIT','DURAND','LEFEBVRE','MOREAU','GARCIA','DAVID','BERTRAND','ROUX','SIMON','MICHEL','LEROY')
$extra = @(9, 10, 11, 12, 14, 15, 16, 18, 19, 0)   # magasins à 3 vendeurs (montagne, IDF, grandes villes)
$vendeurs = New-Object System.Collections.Generic.List[object]
$k = 0
for ($i = 0; $i -lt $magasins.Count; $i++) {
  $n = 2; $base = 25000
  if ($extra -contains $i) { $n = 3; $base = 40000 }
  for ($j = 0; $j -lt $n; $j++) {
    $vendeurs.Add([pscustomobject]@{
      VndID = ('V{0:D2}' -f ($k + 1))
      VndLbl = "$($fn[$k % $fn.Count]) $($ln[[int][math]::Floor($k / $fn.Count) % $ln.Count])"
      MagID = $magasins[$i].MagID
      CibleMens = [int](500 * [math]::Round(($base + $rnd.NextDouble() * 15000) / 500))
    }); $k++
  }
}
$vendorsByStore = @{}
foreach ($v in $vendeurs) {
  if (-not $vendorsByStore.ContainsKey($v.MagID)) { $vendorsByStore[$v.MagID] = New-Object System.Collections.Generic.List[object] }
  $vendorsByStore[$v.MagID].Add($v)
}
$vendeurs | Export-Csv (Join-Path $outDir 'vendeurs.csv') -NoTypeInformation -Delimiter ';' -Encoding utf8BOM

# ---------- CLIENTS ----------
$cities = @('Annecy','Grenoble','Lyon','Marseille','Nice','Toulouse','Bordeaux','Nantes','Rennes','Lille','Strasbourg','Montpellier','Clermont-Ferrand','Dijon','Reims','Rouen','Tours','Limoges','Bayonne','Pau','Metz','Nancy','Paris','Chamonix')
$secteurs = @('Nord-Est','Nord-Ouest','Île-de-France','Sud-Est','Sud-Ouest')
$clients = New-Object System.Collections.Generic.List[object]
for ($i = 1; $i -le 220; $i++) {
  $t = $rnd.NextDouble()
  $typ = if ($t -lt 0.70) { 'Particulier' } elseif ($t -lt 0.85) { 'Club' } elseif ($t -lt 0.95) { 'Entreprise' } else { 'Collectivité' }
  $city = $cities[$rnd.Next($cities.Count)]
  $lbl = if ($typ -eq 'Particulier') { "$($fn[$i % $fn.Count]) $($ln[$i % $ln.Count])" }
    elseif ($typ -eq 'Club') { "Club sportif $city" }
    elseif ($typ -eq 'Entreprise') { "Ste $($ln[$i % $ln.Count])" }
    else { "Ville de $city" }
  $clients.Add([pscustomobject]@{
    CustNo = ('C{0:D4}' -f $i); CliLbl = $lbl; TypCli = $typ
    Ville = $city; Secteur = $secteurs[$rnd.Next($secteurs.Count)]
    Dt1erAchat = Fd ([datetime]::new(2019, 1, 1).AddDays($rnd.Next(0, 1825)))
  })
}
$clients | Export-Csv (Join-Path $outDir 'clients.csv') -NoTypeInformation -Delimiter ';' -Encoding utf8BOM

# ---------- CALENDRIER ----------
$cal = New-Object System.Collections.Generic.List[object]
for ($d = [datetime]::new(2024, 1, 1); $d -le [datetime]::new(2026, 12, 31); $d = $d.AddDays(1)) {
  $cal.Add([pscustomobject]@{
    DateKey = [int]$d.ToString('yyyyMMdd'); Date = Fd $d; Annee = $d.Year
    Trimestre = "T$([int][math]::Ceiling($d.Month / 3))"
    MoisNum = $d.Month; MoisLbl = $d.ToString('MMMM', $fr)
    JourNum = $d.Day; JourSemLbl = $d.ToString('dddd', $fr)
    NumSem = $fr.Calendar.GetWeekOfYear($d, [System.Globalization.CalendarWeekRule]::FirstFourDayWeek, [DayOfWeek]::Monday)
  })
}
$cal | Export-Csv (Join-Path $outDir 'calendrier.csv') -NoTypeInformation -Delimiter ';' -Encoding utf8BOM

# ---------- VENTES ----------
$monthW = @{1 = 1.6; 2 = 1.5; 3 = 0.7; 4 = 0.6; 5 = 0.7; 6 = 1.3; 7 = 1.5; 8 = 1.4; 9 = 0.7; 10 = 0.8; 11 = 0.9; 12 = 1.8 }
$datePool = New-Object System.Collections.Generic.List[datetime]
for ($d = [datetime]::new(2024, 1, 1); $d -le [datetime]::new(2026, 7, 31); $d = $d.AddDays(1)) {
  $n = [int][math]::Round($monthW[$d.Month] * 3)
  for ($j = 0; $j -lt $n; $j++) { $datePool.Add($d) }
}
function Pick-Cat([int]$m) {
  if ($m -in 12, 1, 2) { $w = @(@('SKI', 34), @('SNB', 22), @('RAN', 6), @('VEL', 6), @('ACC', 32)) }
  elseif ($m -in 6, 7, 8) { $w = @(@('SKI', 2), @('SNB', 4), @('RAN', 26), @('VEL', 24), @('ACC', 44)) }
  else { $w = @(@('SKI', 12), @('SNB', 10), @('RAN', 20), @('VEL', 18), @('ACC', 40)) }
  $tot = 0; foreach ($x in $w) { $tot += $x[1] }
  $r = $rnd.NextDouble() * $tot; $c = 0.0
  foreach ($x in $w) { $c += $x[1]; if ($r -lt $c) { return $x[0] } }
  return 'ACC'
}
$canalVals = @('Magasin', 'MAGASIN', 'magasin', 'Web', 'WEB', 'web')
$canalW = @(0.40, 0.15, 0.15, 0.12, 0.09, 0.09)
$statutVals = @('Livree', 'LIVREE', 'livree', 'EnCours', 'encours', 'Annulee')
$statutW = @(0.45, 0.25, 0.15, 0.06, 0.04, 0.05)

$sales = New-Object System.Collections.Generic.List[object]
for ($i = 0; $i -lt 8000; $i++) {
  $d = $datePool[$rnd.Next($datePool.Count)]
  $cat = Pick-Cat $d.Month
  $lst = $prodsByCat[$cat]
  $p = $lst[$rnd.Next($lst.Count)]
  $mg = $magasins[$rnd.Next($magasins.Count)]
  $vs = $vendorsByStore[$mg.MagID]
  $v = $vs[$rnd.Next($vs.Count)]
  $cl = $clients[$rnd.Next($clients.Count)]
  $rq = $rnd.NextDouble(); $qt = if ($rq -lt 0.5) { 1 } elseif ($rq -lt 0.8) { 2 } elseif ($rq -lt 0.95) { 3 } else { 4 }
  $rr = $rnd.NextDouble(); $rem = if ($rr -lt 0.70) { 0 } elseif ($rr -lt 0.90) { 5 } else { 10 }
  $brut = $qt * $p.PU; $net = $brut * (1 - $rem / 100); $cost = $qt * $p.CstA
  $sales.Add([pscustomobject]@{
    _d = $d; VteID = ''; DtVte = Fd $d
    Canal = (PickW $canalVals $canalW); StatutCde = (PickW $statutVals $statutW)
    ProdID = $p.ProdID; Qt = $qt; TxRem = (Num $rem)
    MttBrutTTC = (Num $brut); MttTTcNet = (Num $net); CstLigne = (Num $cost)
    MagID = $mg.MagID; VndID = $v.VndID; CustNo = $cl.CustNo
  })
}
$sorted = $sales | Sort-Object _d
$final = for ($i = 0; $i -lt $sorted.Count; $i++) {
  $s = $sorted[$i]
  [pscustomobject]@{
    VteID = ('V{0:D6}' -f ($i + 1)); DtVte = $s.DtVte; Canal = $s.Canal; StatutCde = $s.StatutCde
    ProdID = $s.ProdID; Qt = $s.Qt; TxRem = $s.TxRem
    MttBrutTTC = $s.MttBrutTTC; MttTTcNet = $s.MttTTcNet; CstLigne = $s.CstLigne
    MagID = $s.MagID; VndID = $s.VndID; CustNo = $s.CustNo
  }
}
$final | Export-Csv (Join-Path $outDir 'ventes.csv') -NoTypeInformation -Delimiter ';' -Encoding utf8BOM

Write-Host "produits=$($produits.Count) magasins=$($magasins.Count) vendeurs=$($vendeurs.Count) clients=$($clients.Count) calendrier=$($cal.Count) ventes=$($final.Count)"
Get-ChildItem $outDir | Select-Object Name, Length
