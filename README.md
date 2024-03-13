DOTS
===

> A Dotfiles Organisation and Tracking System

This repository houses my personal "dotfiles" configurations for various
executables, tools and services.

Configurations are managed based on the [subtree merging][subtree] technique,
where each configuration system is located in a _subdirectory_ on this
"main" branch, as well as its own **"subtree" branch**, denoted as `subtree-*`,
with `*` referring to the configuration's target executable, tool or service.
Note that this repository will use the community-contributed subcommand family
`git subtree`, which is bundled in default Git installations on almost all
platforms.

## Subtree Branches

> One stable branch per each target of configuration

The `subtree-*` branches will be each individual subdirectory present in the
filesystem available in the `main` branch.
Each `subtree-*` branch can be deployed by itself as a stable configuration
directory at its designated place.
The recommended method of deployment is through Git worktrees.

While each `subtree-*` branch will be individually managed, progress on each
branch will need to be merged in to the `main` branch from time to time;
this is especially important for interdependent configurations,
or systems that affect (or are affected by) other systems, to ensure that
a point of commit exists in the `main` branch that ensures stability between
all such systems.

## Subtree **Development** Branches

> Multiple development branches per each target of configuration

For works-in-progress per each `subtree-*` branch, separate branches for
specific purposes and goals may exist.
The naming convention for such branches will be somewhat conforming to:
```
*-<purpose>
```
where `*` is the targeted executable, tool or service of configuration and
`<purpose>` is the specific purpose or goal for the development branch.

For the sake of clarity in tracking diffs between the parent `subtree-*` branch
and its development branches, each `subtree-*` branch will be hosted on its own
separate "remote" repository on GitHub, where the development branches will
exist as its "child(ren)" branches.
The development branches will _not_ be hosted on the _main_ "remote" repository
where the `main` branch will be kept as the initial (parent) branch.

## `main`: "Supertree" Branch

> **ONE** stable branch to rule them all

The `main` branch will consist of several subdirectories, each for a dedicated,
independent configuration for a specific executable, tool or service.
Combined, the `main` branch will essentially be an all-encompassing set of
configurations that can be instantly deployed manually, all on its own.

Correlated commits across different subtree branches will be recorded as such
in the "main" branch, which will be used as a tracking point for all commits
and changes in all branches.
To merge one or more subtree branches into the main branch, this repository will
use the `git-read-tree` functionality.

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[subtree]: https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging.html#_subtree_merge
[license]: ./LICENSE.md
