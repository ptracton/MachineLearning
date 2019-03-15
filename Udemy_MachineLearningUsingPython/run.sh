

emacs \
    -u "$(id -un)" \
    --batch \
    --eval '(load user-init-file)' \
    Notes/MachineLearningUsingPython.org \
    -f org-beamer-export-to-pdf
