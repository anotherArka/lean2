/-
Copyright (c) 2015 Floris van Doorn. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Author: Floris van Doorn

Squareovers
-/

import .square

open eq equiv is_equiv sigma

namespace eq

  -- we give the argument B explicitly, because Lean would find (λa, B a) by itself, which
  -- makes the type uglier (of course the two terms are definitionally equal)
  inductive squareover {A : Type} (B : A → Type) {a₀₀ : A} {b₀₀ : B a₀₀} :
    Π{a₂₀ a₀₂ a₂₂ : A}
     {p₁₀ : a₀₀ = a₂₀} {p₁₂ : a₀₂ = a₂₂} {p₀₁ : a₀₀ = a₀₂} {p₂₁ : a₂₀ = a₂₂}
     (s₁₁ : square p₁₀ p₁₂ p₀₁ p₂₁)
     {b₂₀ : B a₂₀} {b₀₂ : B a₀₂} {b₂₂ : B a₂₂}
     (q₁₀ : pathover B b₀₀ p₁₀ b₂₀) (q₁₂ : pathover B b₀₂ p₁₂ b₂₂)
     (q₀₁ : pathover B b₀₀ p₀₁ b₀₂) (q₂₁ : pathover B b₂₀ p₂₁ b₂₂),
     Type :=
  idsquareo : squareover B ids idpo idpo idpo idpo


  variables {A A' : Type} {B : A → Type}
            {a a' a'' a₀₀ a₂₀ a₄₀ a₀₂ a₂₂ a₂₄ a₀₄ a₄₂ a₄₄ : A}
            /-a₀₀-/ {p₁₀ : a₀₀ = a₂₀} /-a₂₀-/ {p₃₀ : a₂₀ = a₄₀} /-a₄₀-/
            /-a₀₂-/ {p₁₂ : a₀₂ = a₂₂} /-a₂₂-/ {p₃₂ : a₂₂ = a₄₂} /-a₄₂-/
            /-a₀₄-/ {p₁₄ : a₀₄ = a₂₄} /-a₂₄-/ {p₃₄ : a₂₄ = a₄₄} /-a₄₄-/
       {p₀₁ : a₀₀ = a₀₂} /-s₁₁-/ {p₂₁ : a₂₀ = a₂₂} /-s₃₁-/ {p₄₁ : a₄₀ = a₄₂}
       {p₀₃ : a₀₂ = a₀₄} /-s₁₃-/ {p₂₃ : a₂₂ = a₂₄} /-s₃₃-/ {p₄₃ : a₄₂ = a₄₄}
            {s₁₁ : square p₁₀ p₁₂ p₀₁ p₂₁} {s₃₁ : square p₃₀ p₃₂ p₂₁ p₄₁}
            {s₁₃ : square p₁₂ p₁₄ p₀₃ p₂₃} {s₃₃ : square p₃₂ p₃₄ p₂₃ p₄₃}

            {b : B a}
            {b₀₀ : B a₀₀} {b₂₀ : B a₂₀} {b₄₀ : B a₄₀}
            {b₀₂ : B a₀₂} {b₂₂ : B a₂₂} {b₄₂ : B a₄₂}
            {b₀₄ : B a₀₄} {b₂₄ : B a₂₄} {b₄₄ : B a₄₄}
            /-b₀₀-/ {q₁₀ : b₀₀ =[p₁₀] b₂₀} /-b₂₀-/ {q₃₀ : b₂₀ =[p₃₀] b₄₀} /-b₄₀-/
            /-b₀₂-/ {q₁₂ : b₀₂ =[p₁₂] b₂₂} /-b₂₂-/ {q₃₂ : b₂₂ =[p₃₂] b₄₂} /-b₄₂-/
            /-b₀₄-/ {q₁₄ : b₀₄ =[p₁₄] b₂₄} /-b₂₄-/ {q₃₄ : b₂₄ =[p₃₄] b₄₄} /-b₄₄-/
   {q₀₁ : b₀₀ =[p₀₁] b₀₂} /-t₁₁-/ {q₂₁ : b₂₀ =[p₂₁] b₂₂} /-t₃₁-/ {q₄₁ : b₄₀ =[p₄₁] b₄₂}
   {q₀₃ : b₀₂ =[p₀₃] b₀₄} /-t₁₃-/ {q₂₃ : b₂₂ =[p₂₃] b₂₄} /-t₃₃-/ {q₄₃ : b₄₂ =[p₄₃] b₄₄}

  definition squareo := @squareover A B a₀₀
  definition idsquareo [reducible] [constructor] (b₀₀ : B a₀₀) := @squareover.idsquareo A B a₀₀ b₀₀
  definition idso      [reducible] [constructor]               := @squareover.idsquareo A B a₀₀ b₀₀

  definition apds (f : Πa, B a) (s : square p₁₀ p₁₂ p₀₁ p₂₁)
    : squareover B s (apd f p₁₀) (apd f p₁₂) (apd f p₀₁) (apd f p₂₁) :=
  square.rec_on s idso

  definition vrflo : squareover B vrfl q₁₀ q₁₀ idpo idpo :=
  by induction q₁₀; exact idso

  definition hrflo : squareover B hrfl idpo idpo q₁₀ q₁₀ :=
  by induction q₁₀; exact idso

  definition vdeg_squareover {p₁₀'} {s : p₁₀ = p₁₀'} {q₁₀' : b₀₀ =[p₁₀'] b₂₀}
    (r : change_path s q₁₀ = q₁₀')
    : squareover B (vdeg_square s) q₁₀ q₁₀' idpo idpo :=
  by induction s; esimp at *; induction r; exact vrflo

  definition hdeg_squareover {p₀₁'} {s : p₀₁ = p₀₁'} {q₀₁' : b₀₀ =[p₀₁'] b₀₂}
    (r : change_path s q₀₁ = q₀₁')
    : squareover B (hdeg_square s) idpo idpo q₀₁ q₀₁' :=
  by induction s; esimp at *; induction r; exact hrflo

  definition hconcato
    (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) (t₃₁ : squareover B s₃₁ q₃₀ q₃₂ q₂₁ q₄₁)
    : squareover B (hconcat s₁₁ s₃₁) (q₁₀ ⬝o q₃₀) (q₁₂ ⬝o q₃₂) q₀₁ q₄₁ :=
  by induction t₃₁; exact t₁₁

  definition vconcato
    (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) (t₁₃ : squareover B s₁₃ q₁₂ q₁₄ q₀₃ q₂₃)
    : squareover B (vconcat s₁₁ s₁₃) q₁₀ q₁₄ (q₀₁ ⬝o q₀₃) (q₂₁ ⬝o q₂₃) :=
  by induction t₁₃; exact t₁₁

  definition hinverseo (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁)
    : squareover B (hinverse s₁₁) q₁₀⁻¹ᵒ q₁₂⁻¹ᵒ q₂₁ q₀₁ :=
  by induction t₁₁; constructor

  definition vinverseo (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁)
    : squareover B (vinverse s₁₁) q₁₂ q₁₀ q₀₁⁻¹ᵒ q₂₁⁻¹ᵒ :=
  by induction t₁₁; constructor

  definition eq_vconcato {q : b₀₀ =[p₁₀] b₂₀}
    (r : q = q₁₀) (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) : squareover B s₁₁ q q₁₂ q₀₁ q₂₁ :=
  by induction r; exact t₁₁

  definition vconcato_eq {q : b₀₂ =[p₁₂] b₂₂}
    (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) (r : q₁₂ = q) : squareover B s₁₁ q₁₀ q q₀₁ q₂₁ :=
  by induction r; exact t₁₁

  definition eq_hconcato {q : b₀₀ =[p₀₁] b₀₂}
    (r : q = q₀₁) (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) : squareover B s₁₁ q₁₀ q₁₂ q q₂₁ :=
  by induction r; exact t₁₁

  definition hconcato_eq {q : b₂₀ =[p₂₁] b₂₂}
    (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) (r : q₂₁ = q) : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q :=
  by induction r; exact t₁₁

  definition pathover_vconcato {p : a₀₀ = a₂₀} {sp : p = p₁₀} {q : b₀₀ =[p] b₂₀}
    (r : change_path sp q = q₁₀) (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁)
    : squareover B (sp ⬝pv s₁₁) q q₁₂ q₀₁ q₂₁ :=
  by induction sp; induction r; exact t₁₁

  definition vconcato_pathover {p : a₀₂ = a₂₂} {sp : p₁₂ = p} {q : b₀₂ =[p] b₂₂}
    (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) (r : change_path sp q₁₂ = q)
    : squareover B (s₁₁ ⬝vp sp) q₁₀ q q₀₁ q₂₁ :=
  by induction sp; induction r; exact t₁₁

  definition pathover_hconcato {p : a₀₀ = a₀₂} {sp : p = p₀₁} {q : b₀₀ =[p] b₀₂}
    (r : change_path sp q = q₀₁) (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) :
    squareover B (sp ⬝ph s₁₁) q₁₀ q₁₂ q q₂₁ :=
  by induction sp; induction r; exact t₁₁

  definition hconcato_pathover {p : a₂₀ = a₂₂} {sp : p = p₂₁} {s : square p₁₀ p₁₂ p₀₁ p}
    {q : b₂₀ =[p] b₂₂} (t₁₁ : squareover B (s ⬝hp sp) q₁₀ q₁₂ q₀₁ q₂₁)
    (r : change_path sp q = q₂₁) : squareover B s q₁₀ q₁₂ q₀₁ q :=
  by induction sp; induction r; exact t₁₁

  infix ` ⬝ho `:69 := hconcato --type using \tr
  infix ` ⬝vo `:70 := vconcato --type using \tr
  infix ` ⬝hop `:72 := hconcato_eq --type using \tr
  infix ` ⬝vop `:74 := vconcato_eq --type using \tr
  infix ` ⬝pho `:71 := eq_hconcato --type using \tr
  infix ` ⬝pvo `:73 := eq_vconcato --type using \tr

  -- relating squareovers to squares
  definition square_of_squareover (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) :
    square (!con_tr ⬝ ap (λa, p₂₁ ▸ a) (tr_eq_of_pathover q₁₀))
           (tr_eq_of_pathover q₁₂)
           (ap (λq, q ▸ b₀₀) (eq_of_square s₁₁) ⬝ !con_tr ⬝ ap (λa, p₁₂ ▸ a) (tr_eq_of_pathover q₀₁))
           (tr_eq_of_pathover q₂₁) :=
  by induction t₁₁; esimp; constructor
/-
  definition squareover_of_square
    (q : square (!con_tr ⬝ ap (λa, p₂₁ ▸ a) (tr_eq_of_pathover q₁₀))
           (tr_eq_of_pathover q₁₂)
           (ap (λq, q ▸ b₀₀) (eq_of_square s₁₁) ⬝ !con_tr ⬝ ap (λa, p₁₂ ▸ a) (tr_eq_of_pathover q₀₁))
           (tr_eq_of_pathover q₂₁))
    : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁ :=
  sorry
-/

  definition square_of_squareover_ids {b₀₀ b₀₂ b₂₀ b₂₂ : B a}
    {t : b₀₀ = b₂₀} {b : b₀₂ = b₂₂} {l : b₀₀ = b₀₂} {r : b₂₀ = b₂₂}
    (so : squareover B ids (pathover_idp_of_eq t)
                           (pathover_idp_of_eq b)
                           (pathover_idp_of_eq l)
                           (pathover_idp_of_eq r)) : square t b l r :=
  begin
    note H := square_of_squareover so,  -- use apply ... in
    rewrite [▸* at H,+idp_con at H,+ap_id at H,↑pathover_idp_of_eq at H],
    rewrite [+to_right_inv !(pathover_equiv_tr_eq (refl a)) at H],
    exact H
  end

  definition squareover_ids_of_square {b₀₀ b₀₂ b₂₀ b₂₂ : B a}
    {t : b₀₀ = b₂₀} {b : b₀₂ = b₂₂} {l : b₀₀ = b₀₂} {r : b₂₀ = b₂₂} (q : square t b l r)
    : squareover B ids (pathover_idp_of_eq t)
                       (pathover_idp_of_eq b)
                       (pathover_idp_of_eq l)
                       (pathover_idp_of_eq r) :=
  square.rec_on q idso

  -- relating pathovers to squareovers
  definition pathover_of_squareover' (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁)
    : q₁₀ ⬝o q₂₁ =[eq_of_square s₁₁] q₀₁ ⬝o q₁₂ :=
  by induction t₁₁; constructor

  definition pathover_of_squareover {s : p₁₀ ⬝ p₂₁ = p₀₁ ⬝ p₁₂}
    (t₁₁ : squareover B (square_of_eq s) q₁₀ q₁₂ q₀₁ q₂₁)
    : q₁₀ ⬝o q₂₁ =[s] q₀₁ ⬝o q₁₂ :=
  begin
    revert s t₁₁, refine equiv_rect' !square_equiv_eq⁻¹ᵉ (λa b, squareover B b _ _ _ _ → _) _,
    intro s, exact pathover_of_squareover'
  end

  definition squareover_of_pathover {s : p₁₀ ⬝ p₂₁ = p₀₁ ⬝ p₁₂}
    (r : q₁₀ ⬝o q₂₁ =[s] q₀₁ ⬝o q₁₂) : squareover B (square_of_eq s) q₁₀ q₁₂ q₀₁ q₂₁ :=
  by induction q₁₂; esimp [concato] at r;induction r;induction q₂₁;induction q₁₀;constructor

  definition pathover_top_of_squareover (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁)
    : q₁₀ =[eq_top_of_square s₁₁] q₀₁ ⬝o q₁₂ ⬝o q₂₁⁻¹ᵒ :=
  by induction t₁₁; constructor

  definition squareover_of_pathover_top {s : p₁₀ = p₀₁ ⬝ p₁₂ ⬝ p₂₁⁻¹}
  (r : q₁₀ =[s] q₀₁ ⬝o q₁₂ ⬝o q₂₁⁻¹ᵒ)
    : squareover B (square_of_eq_top s) q₁₀ q₁₂ q₀₁ q₂₁ :=
  by induction q₂₁; induction q₁₂; esimp at r;induction r;induction q₁₀;constructor

  definition pathover_of_hdeg_squareover {p₀₁' : a₀₀ = a₀₂} {r : p₀₁ = p₀₁'} {q₀₁' : b₀₀ =[p₀₁'] b₀₂}
    (t : squareover B (hdeg_square r) idpo idpo q₀₁ q₀₁') : q₀₁ =[r] q₀₁' :=
  by induction r; induction q₀₁'; exact (pathover_of_squareover' t)⁻¹ᵒ

  definition pathover_of_vdeg_squareover {p₁₀' : a₀₀ = a₂₀} {r : p₁₀ = p₁₀'} {q₁₀' : b₀₀ =[p₁₀'] b₂₀}
    (t : squareover B (vdeg_square r) q₁₀ q₁₀' idpo idpo) : q₁₀ =[r] q₁₀' :=
  by induction r; induction q₁₀'; exact pathover_of_squareover' t

  definition squareover_of_eq_top (r : change_path (eq_top_of_square s₁₁) q₁₀ = q₀₁ ⬝o q₁₂ ⬝o q₂₁⁻¹ᵒ)
    : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁ :=
  begin
    induction s₁₁, revert q₁₂ q₁₀ r,
    eapply idp_rec_on q₂₁, clear q₂₁,
    intro q₁₂,
    eapply idp_rec_on q₁₂, clear q₁₂,
    esimp, intros,
    induction r, eapply idp_rec_on q₁₀,
    constructor
  end

  definition eq_top_of_squareover (r : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁)
    : change_path (eq_top_of_square s₁₁) q₁₀ = q₀₁ ⬝o q₁₂ ⬝o q₂₁⁻¹ᵒ :=
  by induction r; reflexivity

  definition change_square {s₁₁'} (p : s₁₁ = s₁₁') (r : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁)
    : squareover B s₁₁' q₁₀ q₁₂ q₀₁ q₂₁ :=
  p ▸ r

  /-
  definition squareover_equiv_pathover (q₁₀ : b₀₀ =[p₁₀] b₂₀) (q₁₂ : b₀₂ =[p₁₂] b₂₂)
    (q₀₁ : b₀₀ =[p₀₁] b₀₂) (q₂₁ : b₂₀ =[p₂₁] b₂₂)
    : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁ ≃ q₁₀ ⬝o q₂₁ =[eq_of_square s₁₁] q₀₁ ⬝o q₁₂ :=
  begin
    fapply equiv.MK,
    { exact pathover_of_squareover},
    { intro r, rewrite [-to_left_inv !square_equiv_eq s₁₁], apply squareover_of_pathover, exact r},
    { intro r, }, --need characterization of squareover lying over ids.
    { intro s, induction s, apply idp},
  end
  -/

  definition eq_of_vdeg_squareover {q₁₀' : b₀₀ =[p₁₀] b₂₀}
    (p : squareover B vrfl q₁₀ q₁₀' idpo idpo) : q₁₀ = q₁₀' :=
  begin
    note H := square_of_squareover p,  -- use apply ... in
    induction p₁₀, -- if needed we can remove this induction and use con_tr_idp in types/eq2
    rewrite [▸* at H,idp_con at H,+ap_id at H],
    let H' := eq_of_vdeg_square H,
    exact inj !pathover_equiv_tr_eq H'
  end

  -- definition vdeg_tr_squareover {q₁₂ : p₀₁ ▸ b₀₀ =[p₁₂] p₂₁ ▸ b₂₀} (r : q₁₀ =[_] q₁₂)
  --   : squareover B s₁₁ q₁₀ q₁₂ !pathover_tr !pathover_tr :=
  -- by induction p;exact vrflo

  /- A version of eq_pathover where the type of the equality also varies -/
  definition eq_pathover_dep {f g : Πa, B a} {p : a = a'} {q : f a = g a}
    {r : f a' = g a'} (s : squareover B hrfl (pathover_idp_of_eq q) (pathover_idp_of_eq r)
                                             (apd f p) (apd g p)) : q =[p] r :=
  begin
    induction p, apply pathover_idp_of_eq, apply eq_of_vdeg_square, exact square_of_squareover_ids s
  end

  /- charcaterization of pathovers in pathovers -/
  -- in this version the fibration (B) of the pathover does not depend on the variable (a)
  definition pathover_pathover {a' a₂' : A'} {p : a' = a₂'} {f g : A' → A}
    {b : Πa, B (f a)} {b₂ : Πa, B (g a)} {q : Π(a' : A'), f a' = g a'}
    (r : pathover B (b a') (q a') (b₂ a'))
    (r₂ : pathover B (b a₂') (q a₂') (b₂ a₂'))
    (s : squareover B (natural_square q p) r r₂
                      (pathover_ap B f (apd b p)) (pathover_ap B g (apd b₂ p)))
    : pathover (λa, pathover B (b a) (q a) (b₂ a)) r p r₂ :=
  begin
    induction p, esimp at s, apply pathover_idp_of_eq, apply eq_of_vdeg_squareover, exact s
  end

  definition squareover_change_path_left {p₀₁' : a₀₀ = a₀₂} (r : p₀₁' = p₀₁)
    {q₀₁ : b₀₀ =[p₀₁'] b₀₂} (t : squareover B (r ⬝ph s₁₁) q₁₀ q₁₂ q₀₁ q₂₁)
  : squareover B s₁₁ q₁₀ q₁₂ (change_path r q₀₁) q₂₁ :=
  by induction r; exact t

  definition squareover_change_path_right {p₂₁' : a₂₀ = a₂₂} (r : p₂₁' = p₂₁)
    {q₂₁ : b₂₀ =[p₂₁'] b₂₂} (t : squareover B (s₁₁ ⬝hp r⁻¹) q₁₀ q₁₂ q₀₁ q₂₁)
  : squareover B s₁₁ q₁₀ q₁₂ q₀₁ (change_path r q₂₁) :=
  by induction r; exact t

  definition squareover_change_path_right' {p₂₁' : a₂₀ = a₂₂} (r : p₂₁ = p₂₁')
    {q₂₁ : b₂₀ =[p₂₁'] b₂₂} (t : squareover B (s₁₁ ⬝hp r) q₁₀ q₁₂ q₀₁ q₂₁)
  : squareover B s₁₁ q₁₀ q₁₂ q₀₁ (change_path r⁻¹ q₂₁) :=
  by induction r; exact t

  /- You can construct a square in a sigma-type by giving a squareover -/
  definition square_dpair_eq_dpair {a₀₀ a₂₀ a₀₂ a₂₂ : A}
    {p₁₀ : a₀₀ = a₂₀} {p₀₁ : a₀₀ = a₀₂} {p₂₁ : a₂₀ = a₂₂} {p₁₂ : a₀₂ = a₂₂}
    (s₁₁ : square p₁₀ p₁₂ p₀₁ p₂₁) {b₀₀ : B a₀₀} {b₂₀ : B a₂₀} {b₀₂ : B a₀₂} {b₂₂ : B a₂₂}
    {q₁₀ : b₀₀ =[p₁₀] b₂₀} {q₀₁ : b₀₀ =[p₀₁] b₀₂} {q₂₁ : b₂₀ =[p₂₁] b₂₂} {q₁₂ : b₀₂ =[p₁₂] b₂₂}
    (t₁₁ : squareover B s₁₁ q₁₀ q₁₂ q₀₁ q₂₁) :
    square (dpair_eq_dpair p₁₀ q₁₀) (dpair_eq_dpair p₁₂ q₁₂)
           (dpair_eq_dpair p₀₁ q₀₁) (dpair_eq_dpair p₂₁ q₂₁) :=
  by induction t₁₁; constructor

  definition sigma_square {v₀₀ v₂₀ v₀₂ v₂₂ : Σa, B a}
    {p₁₀ : v₀₀ = v₂₀} {p₀₁ : v₀₀ = v₀₂} {p₂₁ : v₂₀ = v₂₂} {p₁₂ : v₀₂ = v₂₂}
    (s₁₁ : square p₁₀..1 p₁₂..1 p₀₁..1 p₂₁..1)
    (t₁₁ : squareover B s₁₁ p₁₀..2 p₁₂..2 p₀₁..2 p₂₁..2) : square p₁₀ p₁₂ p₀₁ p₂₁ :=
  begin
    induction v₀₀, induction v₂₀, induction v₀₂, induction v₂₂,
    rewrite [▸* at *, -sigma_eq_eta p₁₀, -sigma_eq_eta p₁₂, -sigma_eq_eta p₀₁, -sigma_eq_eta p₂₁],
    exact square_dpair_eq_dpair s₁₁ t₁₁
  end

  definition move_right_of_top_over {p : a₀₀ = a} {p' : a = a₂₀}
    {s : square p p₁₂ p₀₁ (p' ⬝ p₂₁)} {q : b₀₀ =[p] b} {q' : b =[p'] b₂₀}
    (t : squareover B (move_top_of_right s) (q ⬝o q') q₁₂ q₀₁ q₂₁) :
    squareover B s q q₁₂ q₀₁ (q' ⬝o q₂₁) :=
  begin induction q', induction q, induction q₂₁, exact t end

  variables (s₁₁ q₀₁ q₁₀ q₂₁ q₁₂)
  definition squareover_fill_t : Σ (q : b₀₀ =[p₁₀] b₂₀), squareover B s₁₁ q q₁₂ q₀₁ q₂₁ :=
  begin
    induction s₁₁, induction q₀₁ using idp_rec_on, induction q₂₁ using idp_rec_on,
    induction q₁₂ using idp_rec_on, exact ⟨idpo, idso⟩
  end

  definition squareover_fill_b : Σ (q : b₀₂ =[p₁₂] b₂₂), squareover B s₁₁ q₁₀ q q₀₁ q₂₁ :=
  begin
    induction s₁₁, induction q₀₁ using idp_rec_on, induction q₂₁ using idp_rec_on,
    induction q₁₀ using idp_rec_on, exact ⟨idpo, idso⟩
  end

  definition squareover_fill_l : Σ (q : b₀₀ =[p₀₁] b₀₂), squareover B s₁₁ q₁₀ q₁₂ q q₂₁ :=
  begin
    induction s₁₁, induction q₁₀ using idp_rec_on, induction q₂₁ using idp_rec_on,
    induction q₁₂ using idp_rec_on, exact ⟨idpo, idso⟩
  end

  definition squareover_fill_r : Σ (q : b₂₀ =[p₂₁] b₂₂) , squareover B s₁₁ q₁₀ q₁₂ q₀₁ q :=
  begin
    induction s₁₁, induction q₀₁ using idp_rec_on, induction q₁₀ using idp_rec_on,
    induction q₁₂ using idp_rec_on, exact ⟨idpo, idso⟩
  end

end eq
