
## Advtrains contribution guide

advtrains is an Open Source project, and as such lives from contributions of various people, may it be reporting of bugs, submittting patches or translating (translating is not applicable at the moment because I did rarely mark strings).

If you have found a bug or have a feature request, you can open a bug ticket at this issue tracker:
http://mantis.bleipb.de/

### Contributing code
If you want to contribute code, such as fixing a bug or implementing a feature, do one the following:
**If you have a public git repository:**
1. Clone this repository and push it to your own public git repo.
2. implement your change
3. push your changes there

**If not:**
4. Clone this repository to your computer
5. implement your change
6. use `git format-patch <upstream branch>` to generate patch files.
```
$ git format-patch master
0001-Fix-bug-foo.patch
0002-Correct-something.patch
```
**You then have 3 options:**
7. If your contribution is a fix to a bug that has a Mantis ticket, attach your patch files/link to your public repo to this bug's ticket.
8. If not, create a new ticket, apply the tag "Patch/Pull Request", and attach your patch files/link to your public repo there, or
9. send your patch files/link to your public repo via e-mail to mailto:orwell@bleipb.de

### Final note
Whenever you contribute something, I do my best to give you credit for your work.
If you have questions or other remarks, you can contact me via a [Minetest Forum PM](https://forum.minetest.net/ucp.php?i=pm&mode=compose&u=17391)
