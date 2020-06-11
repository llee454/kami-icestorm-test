module Target (module Syntax, module Rtl, module Word, module Fin, {- module EclecticLib, -} module PeanoNat, module CompilerSimple, module Extraction, module LibStruct, {- module Instance, -} module IceStormTest, module Test, getRtl, rtlMod) where
import CompilerSimple hiding (unsafeCoerce, __)
-- import EclecticLib hiding (__)
import PeanoNat
import Fin hiding (unsafeCoerce, Any, f2n)
import IceStormTest hiding (unsafeCoerce, __)
import Rtl
import Syntax hiding (__)
import Extraction hiding (unsafeCoerce, Any)
import Word
import LibStruct hiding (unsafeCoerce, __)
import Test hiding (unsafeCoerce, Any)
import UnverifiedIncompleteCompiler hiding (unsafeCoerce, Any)

rtlMod :: ([String], ([RegFileBase], BaseModule))
rtlMod = separateModRemove testModule
