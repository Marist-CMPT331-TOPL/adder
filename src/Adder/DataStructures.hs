{-
 -  Adder is a small but usable subset of the Python language. It is named
 -  for the Blackadder comedy series, much as the Python language is named
 -  for Monty Python.
 -
 -  This module provides types for representing the values and other
 -  supporting data structures in Adder.
 -}
module Adder.DataStructures
  ( ExpVal (..),
    DenVal,
    StoVal,
    Binding,
    Environment (..),
    Procedure (..),
  )
where

import Adder.Defs (Identifier, Reference)
import Adder.Lang.Syntax (Expression)

-- Storable values are any expressed value
type StoVal = ExpVal

-- Denoted values are any expressed value
type DenVal = Reference

-- TODO Define the expressed values for the Adder language
data ExpVal
  = ExpVal
  deriving (Eq)

-- TODO Implement "to-string" functionality for Adder expressed values
instance Show ExpVal where
  show ExpVal = undefined

{- Recursive "data structure" representation for environments -}

type Binding = (Identifier, DenVal)

-- TODO Reimplement this based on a ribcage representation
data Environment = EmptyEnvironment | Environment Identifier DenVal Environment
  deriving (Eq)

instance Show Environment where
  show env = show $ envToList env

{- Auxiliary functions -}

envToList :: Environment -> [Binding]
envToList EmptyEnvironment = []
envToList (Environment x v savedEnv) = (x, v) : envToList savedEnv

{- Representation of closed procedure (i.e. closure) -}

-- TODO Fix the implementation of un-closed procedures.
data Procedure
  = ClosedProcedure {procVar :: Identifier, procBody :: Expression, procEnv :: Environment}
  | UnclosedProcedure {procVar :: Identifier, procBody :: Expression}
  deriving (Eq, Show)