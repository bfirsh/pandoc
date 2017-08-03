# andreas' pandoc fork

work in progress....

## Continuous compilation

```
./docker-watch-build.sh
```

Then you can add the `pandoc` binary to another container with

```
export PANDOC_BIN=/path/to/pandoc/.stack-work/install/x86_64-linux/lts-8.16/8.0.2/bin/pandoc
docker run --volumes $PANDOC_BIN:/bin/pandoc my-other-image
```

This will expose the `/pandoc` directory in the other container.


## Development

### Haskell resources

Haskell is hard. I skimmed
through [Learn You a Haskell](http://learnyouahaskell.com/chapters)
and
[Real World Haskell](http://book.realworldhaskell.org/read/). The
[parsing chapter](http://dev.stephendiehl.com/fun/002_parsers.html)
from [Write You a Haskell](http://dev.stephendiehl.com/fun/) is good
too for the stuff we're doing.

### Hacking

Follow
the
["quick stack method"](http://pandoc.org/installing.html#quick-stack-method) to
install Stack and build Pandoc.

Emacs has [Intero](https://commercialhaskell.github.io/intero/)
([here](https://stackoverflow.com/questions/26603649/haskell-repl-in-emacs) is
a quick intro). `C-l` to send buffer to the GHCi REPL.

Without Emacs, you can still have a decent environment. Start GHCi with

```
$ stack ghci "--docker-run-args=--interactive=true --tty=false" --no-build --no-load pandoc
```

then load files with

```
Prelude> :load src/Text/Pandoc/Readers/LaTeX.hs
```

Most of the coding will be done on that particular `src/Text/Pandoc/Readers/LaTeX.hs` file. But you'll backtrack up through the source tree, and maybe also out to [pandoc-types](https://hackage.haskell.org/package/pandoc-types), especially the `Text/Pandoc/Builder.hs` and `Text/Pandoc/Definition.hs` files.

When you've loaded in `src/Text/Pandoc/Readers/LaTeX.hs`, you can run the parser from GHCi:

```
λ import Text.Pandoc.Class

λ let options = def{ readerExtensions = extensionsFromList [Ext_raw_tex, Ext_latex_macros], readerInputSources = ["foo.tex"] }

λ runIO $ runParserT parseLaTeX def{ sOptions = options } "source" (tokenize $ T.pack "hello \\emph{world}")
Right (Right (Pandoc (Meta {unMeta = fromList []}) [Para [Str "hello",Space,Emph [Str "world"]]]))
```

You can run specific parts of the parser

```
λ runIO $ runParserT parseAligns def{ sOptions = options } "source" (tokenize $ T.pack "{llrr}")
Right (Right [AlignLeft,AlignLeft,AlignRight,AlignRight])
```

Notice how we have to pack the strings to text with `T.pack`. I think
that's avoided in LaTeX.hs with the `{-# LANGUAGE OverloadedStrings
#-}` thing at the top.

On the REPL you can say `:i` to find out the type and source file of a thing (`:t` will give you just the type definition):

```
λ :i keyval
keyval :: PandocMonad m => LP m (String, String)
    -- Defined at /Users/andreasj/src/pandoc/src/Text/Pandoc/Readers/LaTeX.hs:727:1

λ :t (*>)
(*>) :: Applicative f => f a -> f b -> f b
```

You can't get Haddock docstrings on the REPL yet afaict, but [Hoogle](https://www.haskell.org/hoogle/) is pretty fast and smart:

* [`mappend`](https://www.haskell.org/hoogle/?hoogle=mappend)
* [`>=>`](https://www.haskell.org/hoogle/?hoogle=%3E%3D%3E)
* [`Monad m => a -> m a`](https://www.haskell.org/hoogle/?hoogle=Monad+m+%3D%3E+a+-%3E+m+a)
