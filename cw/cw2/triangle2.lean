import Mathlib.Tactic

inductive MyD₃
  | r : Fin 3 → MyD₃
  | sr: Fin 3 → MyD₃
deriving instance DecidableEq

for MyD₃
namespace MyD₃

def D₃GroupLaw : MyD₃ → MyD₃ → MyD₃
  | r i, r j => r ((i + j) % 3)
  | r i, sr j => sr ((j - i) % 3)
  | sr i, r j => sr ((i + j) % 3)
  | sr i, sr j => r ((j - i) % 3)

def D₃id : MyD₃ := r 0

def D₃inv : MyD₃ → MyD₃
  | r i => r ((3-i) % 3)
  | sr i => sr i

instance : Group (MyD₃) where
  mul := D₃GroupLaw
  mul_assoc := by sorry
  one := D₃id
  one_mul := by sorry
  mul_one := by sorry
  inv := D₃inv
  mul_left_inv := by sorry

/- Prove any theorems about the definitions of multiplication, idetities and inverses and so on here.
such as
theorem r_mul_r (i j : ZMod n) : r i * r j = r (i + j) := rfl
 Also results about cardinality perhaps

 theorem card [NeZero n] : Fintype.card (DihedralGroup n) = 2 * n := by
  rw [← Fintype.card_eq.mpr ⟨fintypeHelper⟩, Fintype.card_sum, ZMod.card, two_mul]
#align dihedral_group.card DihedralGroup.card

theorem nat_card : Nat.card (DihedralGroup n) = 2 * n := by
  cases n
  · rw [Nat.card_eq_zero_of_infinite]
  · rw [Nat.card_eq_fintype_card, card]
   -/

end MyD₃

variable (n : ℕ)

def n_set : Set ℕ := Finset.range n

variable (a1 a2 a3 b1 b2 b3 c1 : n_set n)

def n7 := n_set (n) × n_set (n) × n_set (n) × n_set (n) ×  n_set (n) × n_set (n) × n_set (n)

def example_element : n7 n := (a1, a2, a3, b1, b2, b3, c1)

def rotation_funct : n7 n → n7 n
| ⟨a1, a2, a3, b1, b2, b3, c1 ⟩ => (a2, a3, a1, b2, b3, b1, c1)

def reflection_0_funct : n7 n → n7 n
| ⟨a1, a2, a3, b1, b2, b3, c1 ⟩ => (a1, a3, a2, b3, b2, b1, c1)

def reflection_1_funct : n7 n → n7 n
| ⟨a1, a2, a3, b1, b2, b3, c1 ⟩ => (a2, a1, a3, b1, b3, b2, c1)

def reflection_2_funct : n7 n → n7 n
| ⟨a1, a2, a3, b1, b2, b3, c1 ⟩ => (a3, a2, a1, b2, b1, b3, c1)

open MyD₃

def myaction2: MyD₃ → (n7 n → n7 n)
| r 0 => id
| r 1 => rotation_funct n
| r 2 => (rotation_funct n) ∘ (rotation_funct n)
| sr 0 => reflection_0_funct n
| sr 1 => reflection_1_funct n
| sr 2 => reflection_2_funct n