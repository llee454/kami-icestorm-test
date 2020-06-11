(*
  This module defines a trivial kami module that can be used to
  test the IceStorm toolchain.
*)
Require Import Kami.All.
Require Import Kami.Compiler.Compiler.
Require Import Kami.Compiler.Rtl.
Require Import Kami.Compiler.Test.
Require Import Kami.Simulator.NativeTest.
Require Import Kami.Simulator.CoqSim.Simulator.
Require Import Kami.Simulator.CoqSim.HaskellTypes.
Require Import Kami.Simulator.CoqSim.RegisterFile.
Require Import Kami.Simulator.CoqSim.Eval.
Require Import Kami.WfActionT.
Require Import Kami.SignatureMatch.
Require Import List.
Import ListNotations.

Section test.

Open Scope kami_expr.

Local Definition BadInput : Kind :=
  STRUCT_TYPE {
    "a" :: Bool;
    "b" :: Bit 3
  }.

Local Definition testBaseModule : BaseModule :=
  MODULE {
    Register "testRegister": Bit 3 <- Default with

    Rule "testRule" :=
      Call input : Bit (size (BadInput)) <- "testPort" ();
      LET inputPkt : BadInput <- unpack BadInput #input;
      Read curr : Bit 3 <- "testRegister";
      Write "testRegister" : Bit 3 <-
        IF #inputPkt @% "a"
        then #inputPkt @% "b"
        else #curr + ($1 : Bit 3 @# _);
      If !(#inputPkt @% "a")
      then
        Call _ : Void <- "testOutputPort" (#curr : Bit 3);
        Retv;
      Retv
  }.

Definition testModule : Mod := Base testBaseModule.

Close Scope kami_expr.

End test.

Unset Extraction Optimize.
Separate Extraction
  testModule

  predPack
  orKind
  predPackOr
  createWriteRq
  createWriteRqMask
  pointwiseIntersectionNoMask
  pointwiseIntersectionMask
  pointwiseIntersection
  pointwiseBypass
  getDefaultConstFullKind
  CAS_RulesRf
  Fin_to_list

  getCallsWithSignPerMod
  RtlExpr'
  getRtl

  CompActionSimple
  RmeSimple
  RtlModule
  getRules

  separateModRemove
  separateModHidesNoInline


  testReg
  testAsync
  testSyncIsAddr
  testSyncNotIsAddr
  testNative

  print_Val2
  init_state
  sim_step
  initialize_files_zero
  option_map
  .
