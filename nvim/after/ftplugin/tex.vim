" Only Execute when File Type is TeX
if (&ft != 'tex')
    finish
endif

" Suppress Vim-LaTeX
let b:suppress_latex_suite = 1
setlocal shiftwidth=2 | setlocal tabstop=2
setlocal softtabstop=2 | setlocal smarttab | "Set Tab Spacing to 2

set iskeyword+=\

" Prevent Worldwide Mappings
inoremap <buffer> ' '
inoremap <buffer> " "

" LaTeX-specific Mappings
inoreabb <silent> <buffer> \docu \documentclass[]{<++>}<Esc>6hi<C-R>
inoreabb <silent> <buffer> \useo \usepackage[]{<++>}<Esc>6hi<C-R>
inoreabb <silent> <buffer> \usep \usepackage{}<Left><C-R>
inoreabb <silent> <buffer> \part \part{}<Left><C-R>
inoreabb <silent> <buffer> \chap \chapter{}<Left><C-R>
inoreabb <silent> <buffer> \sect \section{}<Left><C-R>
inoreabb <silent> <buffer> \subs \subsection{}<Left><C-R>
inoreabb <silent> <buffer> \sub2 \subsubsection{}<Left><C-R>
inoreabb <silent> <buffer> \frac \frac{}{<++>}<++><Esc>10hi<C-R>
inoreabb <silent> <buffer> \begin \begin{}<Esc>o\end{<++>}<Esc>khi<C-R>
inoremap <buffer> <C-b> \textbf{}<++><Esc>4hi
inoremap <buffer> <C-t> \textit{}<++><Esc>4hi

" Latex-Specific Text Abbreviations
inoreabb <silent> <buffer> \-> \textrightarrow{}

" LaTeX-Specific AutoClose
inoremap <buffer> ` `'<++><Esc>4hi
inoremap <buffer> `` ``''<++><Esc>5hi
inoremap <buffer> $ $$<++><Esc>4hi
inoremap <buffer> \( \(\)<++><Esc>5hi
inoremap <buffer> \[ \[  \]<++><Esc>6hi
inoremap <buffer> [[ \left[\right]<++><Esc>10hi
inoremap <buffer> {{ \left\{\right\}<++><Esc>11hi
inoremap <buffer> (( \left(\right)<++><Esc>10hi

" LaTeX-Specific Selection AutoClose
" AutoClose overwrites VIM clipboard -> needs update
vmap <buffer> ` di`<Esc>p
vmap <buffer> `` di``<Esc>p
vmap <buffer> \( di\(<Esc>p
vmap <buffer> \[ di\[<Esc>p
vmap <buffer> [[ di[[<Esc>p
vmap <buffer> {{ di{{<Esc>p
vmap <buffer> (( di((<Esc>p
vmap <buffer> \$ di$<Esc>p
vmap <buffer> <C-b> di<C-b><Esc>p
vmap <buffer> <C-t> di<C-t><Esc>p

" LaTeX-specific Greek Letter Mappings
inoremap <buffer> @A \mathrm{A}
inoremap <buffer> @a \alpha
inoremap <buffer> @B \mathrm{B}
inoremap <buffer> @b \beta
inoremap <buffer> @C \mathrm{X}
inoremap <buffer> @c \chi
inoremap <buffer> @D \Delta
inoremap <buffer> @d \delta
inoremap <buffer> @E \mathrm{E}
inoremap <buffer> @e \epsilon
inoremap <buffer> @F \Phi
inoremap <buffer> @f \phi
inoremap <buffer> @G \Gamma
inoremap <buffer> @g \gamma
inoremap <buffer> @H \mathrm{H}
inoremap <buffer> @h \eta
inoremap <buffer> @I \mathrm{I}
inoremap <buffer> @i \iota
inoremap <buffer> @K \mathrm{K}
inoremap <buffer> @k \kappa
inoremap <buffer> @L \Lambda
inoremap <buffer> @l \lambda
inoremap <buffer> @M \mathrm{M}
inoremap <buffer> @m \mu
inoremap <buffer> @N \mathrm{N}
inoremap <buffer> @n \nu
inoremap <buffer> @O \mathrm{O}
inoremap <buffer> @o \mathrm{o}
inoremap <buffer> @P \Pi
inoremap <buffer> @p \pi
inoremap <buffer> @Q \Theta
inoremap <buffer> @q \theta
inoremap <buffer> @R \mathrm{P}
inoremap <buffer> @r \rho
inoremap <buffer> @S \Sigma
inoremap <buffer> @s \sigma
inoremap <buffer> @T \mathrm{T}
inoremap <buffer> @t \tau
inoremap <buffer> @U \Upsilon
inoremap <buffer> @u \upsilon
inoremap <buffer> @W \Omega
inoremap <buffer> @w \omega
inoremap <buffer> @X \Xi
inoremap <buffer> @x \xi
inoremap <buffer> @Y \Psi
inoremap <buffer> @y \psi
inoremap <buffer> @Z \mathrm{Z}
inoremap <buffer> @z \zeta
inoremap <buffer> @Ve \Varepsilon
inoremap <buffer> @Vr \Varrho
inoremap <buffer> @Vk \Varkappa
inoremap <buffer> @Vq \Vartheta
inoremap <buffer> @Vs \Varsigma
inoremap <buffer> @Vp \Varpi
inoremap <buffer> @Ve \Varepsilon
inoremap <buffer> @Vr \Varrho
inoremap <buffer> @Vf \Varphi
inoremap <buffer> @ve \varepsilon
inoremap <buffer> @vr \varrho
inoremap <buffer> @vk \varkappa
inoremap <buffer> @vq \vartheta
inoremap <buffer> @vs \varsigma
inoremap <buffer> @vp \varpi
inoremap <buffer> @ve \varepsilon
inoremap <buffer> @vr \varrho
inoremap <buffer> @vf \varphi
