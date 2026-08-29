#import "@preview/cades:0.3.1": qr-code
#import "@preview/ctheorems:1.1.3": *
#import "@preview/curryst:0.5.0": prooftree, rule
#import "@preview/diagraph:0.3.5": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/oxifmt:1.0.0": strfmt
#import "@preview/touying:0.6.1": *

#import themes.university: *
#show: thmrules

#let thmplain = thmbox.with(
  breakable: false,
  radius: 0pt,
  inset: (left: 0.5em, top: 0.75em, bottom: 0.75em),
  padding: (y: 0pt),
  base_level: 0,
  fill: luma(240),
)
#let theorem = thmplain("theorem", "定理")
#let lemma = thmplain("theorem", "補題")
#let definition = thmplain("theorem", "定義")
#let proposition = thmplain("theorem", "命題")
#let corollary = thmplain("theorem", "系")
#let example = thmplain("theorem", "例").with(numbering: none)
#let fact = thmplain("theorem", "事実")
#let remark = thmplain("theorem", "注意")
#let problem = thmplain("theorem", "問題")
#let proof = thmproof("proof", "証明").with(breakable: false)
#let struct(body) = block(
  width: 100%,
  breakable: true,
  stroke: (left: (thickness: 1pt, paint: luma(230))),
  inset: (left: 12pt, top: 5pt, bottom: 8pt),
)[#body]

#let Pred = $serif("Pred")$
#let Sent = $serif("Sent")$
#let Pow(s) = $cal("P")(#s)$
#let True = $serif("True")$
#let False = $serif("False")$
#let setminus = $backslash$

#let mand = $op(text("and"))$
#let mor = $op(text("or"))$

#let box = $square.stroked$
#let dia = $diamond.stroked$
#let rhd = $triangle.r.stroked$

#let FrameClass = $bb("F")$
#let HilbertSystem = $frak("H")$
#let Thm = $upright("Thm")$

#let proves = $tack.r$
#let nproves = $tack.r.not$
#let models = $tack.r.double$
#let nmodels = $tack.r.double.not$

#let Bew = $bold(upright("Pr"))$
#let Con = $bold(upright("Con"))$

#let ulcorner = $⌈$
#let urcorner = $⌉$
#let GoedelNum(x) = $lr(ulcorner #x urcorner)$

#let Axiom(A) = $sans(upright(#A))$
#let AxiomK = $Axiom("K")$
#let AxiomT = $Axiom("T")$
#let Axiom4 = $Axiom("4")$
#let Axiom5 = $Axiom("5")$
#let AxiomB = $Axiom("B")$
#let AxiomD = $Axiom("D")$
#let AxiomP = $Axiom("P")$
#let AxiomL = $Axiom("L")$
#let AxiomM = $Axiom("M")$
#let AxiomDot2 = $Axiom(".2")$
#let AxiomDot3 = $Axiom(".3")$

#let Rule(R) = $upright((#R))$
#let RuleMP = $Rule("MP")$
#let RuleNec = $Rule("Nec")$
#let RuleLoeb = $Rule("Löb")$
#let RuleHenkin = $Rule("Henkin")$

#let Logic(L) = $bold(upright(#L))$
#let LogicK = $Logic("K")$
#let LogicF = $Logic("F")$
#let LogicWF = $Logic("WF")$
#let LogicVF = $Logic("VF")$

#let Arith(A) = $bold(upright(#A))$
#let PA = $Arith("PA")$

#let And = $class("relation", \&)$

#let goedelTr = $cal("G")$
#let corsiTr = $cal("C")$

#show link: set text(blue)

#show: university-theme.with(
  aspect-ratio: "16-9",
  align: horizon,
  config-info(
    title: [Very Weak Subintuitionistic Logic],
    subtitle: [とても弱い下位直観主義論理について],
    author: [野口 真柊, 倉橋 太志],
    date: [2026/09/04 @ 日本数学会秋季総合分科会],
    institution: [神戸大学システム情報学研究科 M2],
  ),
)
#set text(font: "Shippori Antique B1", size: 16pt)
#show raw: set text(font: "JuliaMono", size: 1em)
#show link: set text(font: "JuliaMono", fill: luma(120))
#show footnote.entry: set text(size: .75em)

#set heading(numbering: numbly("{1}.", default: "1.1"))
#set cite(form: "prose")

#show link: underline

#title-slide()

#grid(
  columns: (1fr, auto),
  column-gutter: 12pt,
  inset: (x: 32pt),
  [
    - スライド: #link("https://sno2wman.github.io/slides-for-Mathsoc2026Autumn/main.pdf")
    - プレプリント: #link("https://arxiv.org/abs/2605.20769")

    - Formalized Formal Logic: この発表内容はLean4で形式化して検証しています．
      - コードは #link("https://github.com/FormalizedFormalLogic/VeryWeakSubintuitionistic") にあります．
  ],
  [
    #qr-code("https://sno2wman.github.io/slides-for-Mathsoc2026Autumn/main.pdf", width: 180pt)
  ],
)

= はじめに

== 地図

上は命題論理，下は様相論理．実線は論理の包含関係，点線はModal Companionを表す．

#figure(gap: 1em)[
  #let nodes = (
    "VF": (label: $Logic("VF")$, pos: (0, 0)),
    "VFSer": (label: $Logic("VF") + not not top$, pos: (0.5, -0.5)),
    "WF": (label: $Logic("WF")$, pos: (1, 0)),
    "F": (label: $Logic("F")$, pos: (2, 0)),
    "FSer": (label: $Logic("F") + not not top$, pos: (2.5, -0.5)),
    "BPL": (label: $Logic("BPL")$, pos: (3, 0)),
    "VPL": (label: $Logic("VPL")$, pos: (3.5, -0.5)),
    "Int": (label: $Logic("Int")$, pos: (4, 0)),
    "KC": (label: $Logic("KC")$, pos: (5, 0)),
    "LC": (label: $Logic("LC")$, pos: (6, 0)),
    "Cl": (label: $Logic("Cl")$, pos: (7, 0)),
    "N": (label: $Logic("N")$, pos: (0, 2)),
    "NPBox": (label: $Logic("NP"^box)$, pos: (0.5, 2.5)),
    "NPDia": (label: $Logic("NP"^dia)$, pos: (0.5, 1.5)),
    "ND": (label: $Logic("ND")$, pos: (0.5, 3.0)),
    "EN": (label: $Logic("EN")$, pos: (1, 2)),
    "K": (label: $Logic("K")$, pos: (2, 2)),
    "KD": (label: $Logic("KD")$, pos: (2.5, 2.5)),
    "K4": (label: $Logic("K4")$, pos: (3, 2)),
    "GL": (label: $Logic("GL")$, pos: (3.5, 2.5)),
    "S4": (label: $Logic("S4")$, pos: (4, 2)),
    "S4.2": (label: $Logic("S4.2")$, pos: (5, 2)),
    "S4.3": (label: $Logic("S4.3")$, pos: (6, 2)),
    "S5": (label: $Logic("S5")$, pos: (7, 2)),
  )
  #let edges = (
    ("VF", "WF"),
    ("WF", "F"),
    ("VF", "VFSer"),
    ("F", "BPL"),
    ("BPL", "Int"),
    ("Int", "KC"),
    ("KC", "LC"),
    ("LC", "Cl"),
    ("N", "EN"),
    ("EN", "K"),
    ("F", "FSer"),
    ("K", "K4"),
    ("K4", "S4"),
    ("S4", "S4.2"),
    ("S4.2", "S4.3"),
    ("S4.3", "S5"),
    ("N", "NPBox"),
    ("N", "NPDia"),
    ("N", "ND"),
    ("K4", "GL"),
    ("BPL", "VPL"),
    ("K", "KD"),
    ("NPDia", "KD"),
    ("NPBox", "KD"),
    ("ND", "KD"),
    ("VFSer", "FSer"),
  )
  #let MC = (
    ("VF", "N"),
    ("VF", "NPBox"),
    ("VFSer", "NPDia"),
    ("WF", "EN"),
    ("F", "K"),
    ("BPL", "K4"),
    ("Int", "S4"),
    ("KC", "S4.2"),
    ("LC", "S4.3"),
    ("Cl", "S5"),
    ("VPL", "GL"),
    ("FSer", "KD"),
  )

  #diagram(
    spacing: 3.5em,
    edges.map(e => edge(nodes.at(e.at(0)).pos, nodes.at(e.at(1)).pos, "<-")),
    MC.map(e => edge(nodes.at(e.at(0)).pos, nodes.at(e.at(1)).pos, stroke: luma(120), bend: -20deg, "<-->")),
    nodes.values().map(n => node(n.pos, text(n.label))),
  )
  #place(
    top + left,
    dx: -10pt,
    dy: -10pt,
    [
      #rect(width: 320pt, height: 300pt, fill: blue.transparentize(90%), stroke: blue.transparentize(50%), radius: 24pt)
      #text(fill: blue, size: 0.8em)[このあたりのことを話します．]
    ],
  )
  #place(
    top + left,
    dx: -10pt,
    dy: -10pt,
    [
      #rect(
        width: 120pt,
        height: 80pt,
        fill: purple.transparentize(90%),
        stroke: purple.transparentize(50%),
        radius: 24pt,
      )

    ],
  )
  #place(
    top + left,
    dx: 20pt,
    dy: 80pt,
    [#text(fill: purple, size: 0.8em)[今回得られた結果]],
  )
  #place(
    top + left,
    dx: 320pt,
    dy: -10pt,
    [
      #rect(
        width: 400pt,
        height: 300pt,
        fill: luma(150).transparentize(90%),
        stroke: luma(150).transparentize(50%),
        radius: 24pt,
      )
      #text(fill: luma(150), size: 0.8em)[よく知られている事実]
    ],
  )
]

#let Fml = $serif("Fml")$

== Gödel-McKinsey-Tarskiの定理

直観主義命題論理 $Logic("Int")$ と様相論理 $Logic("S4")$ の間には深い関係がある．

#fact[@Göd33,@MT48][
  $
    Logic("Int") proves A <==> Logic("S4") proves A^goedelTr
  $
]


#definition[
  Gödel変換 $(dot.c)^goedelTr : Fml_upright("P") -> Fml_upright("M")$．

  - $p^goedelTr mapsto box p$，ただし $p$ は命題変数．
  - $bot^goedelTr mapsto bot$．
  - $(A -> B)^goedelTr mapsto box (A^goedelTr -> B^goedelTr)$
  - $(A and B)^goedelTr mapsto A^goedelTr and B^goedelTr$
  - $(A or B)^goedelTr mapsto A^goedelTr or B^goedelTr$
]

== $Logic("S4")$ の拡張について

#definition[
  命題論理 $L$ と様相論理 $M$ について $L proves A <==> M proves A^goedelTr$ なら $M$ は $L$ のModal Companionであると言う．
]

$Logic("S4")$ より強い論理に関するModal Companionはよく知られている．

#fact[cf. @CZ97][
  - $Logic("S4.2") & : Logic("S4") + dia box p -> box dia p$ は弱排中律・Jankovの論理 $Logic("KC") : Logic("Int") + not p or not not p$ のModal Companion．
  - $Logic("S4.3") & : Logic("S4") + box (box p -> q) or box (box q -> p)$ はGödel-Dummettの論理 $Logic("LC") : Logic("Int") + (p -> q) or (q -> p)$ のModal Companion．
  - $Logic("S5") & : Logic("S4") + p -> box dia p$ は古典論理 $Logic("Cl") : Logic("Int") + p or not p$ のModal Companion．
]

#text(size: 1.5em)[
  Question 1: $Logic("S4")$ より弱い様相論理に対応する命題論理を考えたい．
]

== CorsiのSubintuitionitic Logic $LogicF$

@Cor87 による下位直観主義論理 $LogicF$．
$Logic("F")$ は $Logic("Int")$ よりも弱い．

#definition[
  次の公理と規則でHilbert流で定める論理を $LogicF$ と呼ぶ．\ (この公理化は @dJSM17 による)

  #grid(
    columns: 3,
    column-gutter: 48pt,
    align: top,

    [
      1. $A and B -> A$
      2. $A and B -> B$
      3. $A -> A or B$
      4. $B -> A or B$
      5. $A -> A$
      6. $bot -> A$
    ],
    [
      7. $A and (B or C) -> (A and B) or (A and C)$
      8. $(A -> B) and (A -> C) -> (A -> B and C): Axiom("C")$
      9. $(A -> C) and (B -> C) -> (A or B -> C): Axiom("D")$
      10. $(A -> B) and (B -> C) -> (A -> C): Axiom("I")$
    ],
    [
      11. #prooftree(rule(name: Rule("MP"), $B$, $A -> B$, $A$))
      12. #prooftree(rule(name: Rule("RA"), $A and B$, $A$, $B$))
      13. #prooftree(rule(name: Rule("AF"), $B -> A$, $A$))
    ],
  )
]


#pagebreak()

最小の正規様相論理 $LogicK$ は $LogicF$ の様相同伴．

#fact[@Cor87][
  $
    LogicF proves A <==> Logic("K") proves A^corsiTr
  $
]

ただし元々のGödel変換は $p^goedelTr mapsto box p$ だったが，ここでは少し変えたものを使う．
変換の違いは付値の遺伝性によって生じる．

#definition[
  CorsiのGödel変換 $(dot.c)^corsiTr : Fml_upright("P") -> Fml_upright("M")$ は 命題変数について $p^corsiTr mapsto p$ とする．それ以外は $g$ と同じ．
]

以降は主にこちらの変換で考える．



#text(size: 1.5em)[
  Question 2: $Logic("K")$ より弱い様相論理に対応する命題論理を考えたい．
]

= 得られた結果: 論理 $LogicVF$

== 様相論理のFMT意味論

#definition[
  $Logic("Cl")$ に必然化則 $#prooftree(rule(name: Rule("Nec"), $box A$, $A$))$ を入れた論理を $Logic("N")$ と呼ぶ．
]

Fitting, Marek, Truszczyńskiは $Logic("N")$ の分析のために次の意味論を導入した．(cf: @FMT92)

#definition[
  様相論理のFMTモデル $M := chevron.l W, \{R_A\}_(A in Fml_(upright("M"))), V chevron.r$．\
  - $W$ は非空．
  - $R_A$ は様相論理式で添字付けられた2項関係 $Fml_upright("M") times W times W$．

  $box A$ の充足関係は以下で定める（$R_A$ 関係だけ見る．）
  $
    M, x forces box A <==> forall y. x R_A y ==> M, y forces A
  $
]

#fact[@FMT92][
  $Logic("N")$ は全ての様相論理のFMTモデルのクラスに対し健全かつ完全．
]

この意味論を命題論理に上手く持ち込む．

== 命題論理のFMT意味論

#definition[
  命題論理のFMTモデル $M := chevron.l W, \{R_A\}_(A in Fml_(upright("P"))), r, V chevron.r$．\
  - $R_A$ は命題論理式で添字付けられた2項関係 $Fml_upright("P") times W times W$．
  - $r$ は根で，任意の論理式 $A$ と $x in W$ に対し $r R_A x$．

  $A -> B$ の充足関係は以下で定める（$R_(A -> B)$ 関係だけ見る．）
  $
    M, x forces A -> B <==> forall y. x R_(A -> B) y, M, y forces A ==> M, y forces B
  $

  モデル上の妥当性 $M models A$ : 全ての $x in W$ について $M, x forces A$
]
この意味論に対応する命題論理は何か？

== Very Weak Subintuitionistic Logic $LogicVF$

#definition[
  次の公理と規則でHilbert流で定める論理を $LogicVF$ と呼ぶ．

  #grid(
    columns: 3,
    column-gutter: 48pt,
    align: top,

    [
      1. $A and B -> A$
      2. $A and B -> B$
      3. $A -> A or B$
      4. $B -> A or B$
      5. $A -> A$
      6. $bot -> A$
    ],
    [
      7. $A and (B or C) -> (A and B) or (A and C)$
      8. #prooftree(rule(name: Rule("RC"), $A -> B and C$, $A -> B$, $A -> C$))
      9. #prooftree(rule(name: Rule("RD"), $A or B -> C$, $A -> C$, $B -> C$))
      10. #prooftree(rule(name: Rule("RI"), $A -> C$, $A -> B$, $B -> C$))
    ],
    [
      11. #prooftree(rule(name: Rule("MP"), $B$, $A -> B$, $A$))
      12. #prooftree(rule(name: Rule("RA"), $A and B$, $A$, $B$))
      13. #prooftree(rule(name: Rule("AF"), $B -> A$, $A$))
    ],
  )
]

#pagebreak()

#theorem[$LogicVF$ は選言特性を持つ: $LogicVF proves A or B$ ならば $LogicVF proves A$ または $LogicVF proves B$．]

#theorem[$LogicVF$ は全ての命題論理の（有限）FMTモデルのクラスに対し健全かつ完全．]

反例モデルを構成して次がわかる．

#theorem[
  - $LogicVF nproves not (p and not p)$．
  - $LogicVF nproves not not top$．
  - $LogicVF nproves (top -> (p and q)) <-> (top -> (q and p))$．
]

Modal Companionも確認できる．

#theorem[
  $LogicVF proves A <==> Logic("N") proves A^corsiTr$
]

= $LogicVF$ の拡張

== 継続性の公理

$LogicVF nproves not not top$ だったが実は $LogicF nproves not not top$ でもある．\
$LogicF$ のKripke意味論上では $not not top$ は継続性(seriality)を表す．

#definition[
  2項関係 $R$ が継続的(serial): $forall x. exists y. x R y$
]

$LogicVF$ 上でも$not not top$ は 継続性を表す．

#definition[
  命題論理/様相論理のFMTモデル $M$ が 命題論理式/様相論理式 $A$ に対して $A$-継続的: $forall x, exists y, x R_A y$．
]

#lemma[
  命題論理のFMTモデル $M$ において，$M models not not top$ であることと $M$ が $not top$-継続的であることは同値．
]

#theorem[
  $LogicVF + not not top$ は $not top$-継続的な命題論理FMTモデルのクラスに対し健全かつ完全である．
]

== 継続性に関する現象

#fact[@KK25][
  $Logic("NP"^box) := Logic("N") + not box bot$ は $bot$-継続的な様相論理のFMTモデルのクラスに対し健全かつ完全である．
]

$Logic("NP"^box)$ は $LogicVF + not not top$ のModal Companionになりそうと思うが，実はそうならない．

#theorem[
  任意の論理式 $A$ に対し，以下は同値．
  1. $LogicVF proves A$
  2. $Logic("N") proves A^corsiTr$
  3. $Logic("NP"^box) proves A^corsiTr$

  つまり $Logic("NP"^box)$ も $LogicVF$ のModal Companionである．
]

したがって $Logic("NP"^box)$ は $Logic("VF") + not not top$ のModal Companionではない．（そうだとしたら $LogicVF = LogicVF + not not top$）

#pagebreak()

$Logic("K")$ 上では同値だった $not box bot$ と $not box not top$ は $Logic("N")$ 上では同値でない．\
このことが微妙な違いを引き起こしている．

#theorem[
  $Logic("NP"^dia)$ は $not top$-継続的な様相論理のFMTモデルのクラスに対し健全かつ完全．
]

#theorem[
  $LogicVF + not not top proves A <==> Logic("NP"^dia) proves A^corsiTr$．つまり $Logic("NP"^dia)$ は $LogicVF + not not top$ のModal Companionである．
]

= おわりに

== まとめ

#text(size: 1.25em)[
  - とても弱い命題論理 $LogicVF$ を導入し，意味論を導入して完全性を示した．

  - $Logic("N")$ は $LogicVF$ のModal Companionである．

  - $LogicVF$ 上の継続性に関する拡張を分析した．
]

== ありがとうございました

#grid(
  align: center,
  columns: 1fr,
  [
    #qr-code("https://sno2wman.github.io/slides-for-Mathsoc2026Autumn/main.pdf", width: 140pt)
    #link("https://sno2wman.github.io/slides-for-Mathsoc2026Autumn/main.pdf")
  ],
)


== 参考文献

#show bibliography: set text(lang: "en", size: 16pt)
#bibliography(title: none, "references.yml", style: "elsevier-harvard")
