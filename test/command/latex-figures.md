```
% pandoc -f latex -t native
\begin{figure}
  \includegraphics{foo.png}
  \caption{Foo}
  \label{fig:foo}
\end{figure}

^D
[Para [Image ("",[],[]) [Str "Foo",Span ("",[],[("data-label","fig:foo")]) []] ("foo.png","fig:")]]
```

```
% pandoc -f latex -t native
\begin{figure}
  \includegraphics{foo.png}
  \caption{Foo}
  \vspace{-16pt}
  \label{fig:foo}
\end{figure}

^D
[Para [Image ("",[],[]) [Str "Foo",Span ("",[],[("data-label","fig:foo")]) []] ("foo.png","fig:")]]
```
