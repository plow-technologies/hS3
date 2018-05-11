{-# LANGUAGE NoMonomorphismRestriction#-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Network.AWS.ArrowUtils
-- Copyright   :
-- License     :
--
-- Helper functions for working with HXT.  Scraped from <haskell.org>.
-----------------------------------------------------------------------------

module Network.AWS.ArrowUtils (
  split, unsplit, atTag, text
)

where

import Control.Arrow
import Control.Arrow.ArrowTree
import Data.Tree.NTree.TypeDefs (NTree)
import Text.XML.HXT.Arrow.XmlArrow
import Text.XML.HXT.DOM.TypeDefs (XmlTree, XNode)

-- misc. functions for working with arrows (and HXT)

split :: (Arrow a) => a b (b, b)
split = arr (\x -> (x,x))

unsplit :: (Arrow a) => (b -> c -> d) -> a (b, c) d
unsplit = arr . uncurry

atTag :: ArrowXml a => String -> a (NTree XNode) XmlTree
atTag tag = deep (isElem >>> hasName tag)

text :: ArrowXml cat => cat (NTree XNode) String
text = getChildren >>> getText
