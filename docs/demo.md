# POC demonstration

1. Push `develop-s34`: CI runs, with no deployment.
2. Merge into `feature-eint1-f26`: the feature branch deploys to `eint1`.
3. Open `feature-eint1-f26` into either `release-eqa-demo` or
   `release-epreprod-demo`: the PR workflow runs CI and stage validation.
4. Merge: tag `f26` is created and the release artifact deploys to the selected
   shared environment.
5. For this isolated branch test, open the release branch into
   `simplified-version-2`: the PR workflow finds the successful EQA or ePreProd
   deployment rather than requesting another deployment.
6. Merge: the same artifact deploys to prod, is smoke tested and verified, then
   receives the automatic `v0.0.<delivery-run-number>` tag and GitHub Release.
   No label is needed and `main` is not changed.
