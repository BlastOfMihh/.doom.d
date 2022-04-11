;; mihh/forces.el -*- lexical-binding: t; -*-


;; (map! :leader
;;       (:prefix ("e" . "execute")
;;         :desc "C/C++"
;;         "c" #'compileandrun))
;; (defun compileandrun()
;;   (interactive)
;;   (let* (
;;          (src (file-name-nondirectory (buffer-file-name)))
;;          (exe (file-name-sans-extension src))
;;          )
;;     (compile (concat "g++ " src " -o " exe " && timeout 3s ./" exe ))))

(defun runc3()
  "Build and runc .cpp files"
  (interactive)
  (if (or (string= major-mode "c++-mode") (boundp 'file))
      (let ((a 10))
        (if (string= major-mode "c++-mode")
            (setq file (buffer-file-name (window-buffer (minibuffer-selected-window)))))
        (evil-write-all nil)

        (setq code-buf-default-directory default-directory)
        ;; (if (boundp 'buf)
        ;;      (pop-to-buffer buf)
        ;;   (setq buf (+vterm/toggle nil)))

        ;; (compile (concat "g++ " file " -o && timeout 3s ./" exe ))
        ;; (vterm-send-string (concat "cd " code-buf-default-directory "; ") )
        (compile (concat "cd " code-buf-default-directory "; " "g++ '" file "' -o ~/dDg; timeout 3s ~/dDg; rm ~/dDg;") )
        ;; (vterm-send-return)
        ;; (with-current-buffer buf
        ;;   (evil-normal-state))
        ;; (er-switch-to-previous-buffer)
        )
    )
  )

(map! :desc "Run c++ code" "<f9>" #'runc3)
