{-# LANGUAGE ConstraintKinds #-}
module Control.Carrier
( -- * Re-exports
  module Control.Carrier.Class
, module Control.Carrier.Pure
, module Control.Effect.Class
, (:+:)(..)
, Has
, send
) where

import {-# SOURCE #-} Control.Carrier.Class
import Control.Carrier.Pure
import Control.Effect.Class
import Control.Effect.Sum

type Has eff sig m = (Inject eff sig, Carrier sig m)

send :: Has eff sig m => eff m a -> m a
