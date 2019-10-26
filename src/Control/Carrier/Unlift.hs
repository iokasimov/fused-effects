{-# LANGUAGE FlexibleInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, TypeOperators, UndecidableInstances #-}
module Control.Carrier.Unlift
( -- * Unlift carrier
  UnliftC(..)
  -- * Unlift effect
, module Control.Effect.Unlift
) where

import Control.Algebra
import Control.Applicative (Alternative)
import Control.Effect.Unlift
import Control.Monad (MonadPlus)
import qualified Control.Monad.Fail as Fail
import Control.Monad.Fix
import Control.Monad.IO.Class
import Control.Monad.Trans.Class

newtype UnliftC m a = UnliftC { runUnlift :: m a }
  deriving (Alternative, Applicative, Functor, Monad, Fail.MonadFail, MonadFix, MonadIO, MonadPlus)

instance MonadTrans UnliftC where
  lift = UnliftC

instance Algebra sig m => Algebra (Unlift m :+: sig) (UnliftC m) where
  alg (L (Unlift with k)) = with runUnlift >>= k
  alg (R other)           = UnliftC (handleCoercible other)
