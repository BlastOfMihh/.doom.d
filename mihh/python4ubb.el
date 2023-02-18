;;; mihh/python4ubb.el -*- lexical-binding: t; -*-



(add-hook 'python-mode-hook
          (lambda()
            (map!
             ;; :after term-mode-hook
             ;; :mode term-mode
             ;; :map term-mode-map
             :leader
             :prefix "e"
             :desc "RUN PYTHON RUN"
             "r" #'python_run_main)))


;; (defun my-echo ()
;;   (interactive)
;;   (switch-to-buffer "*terminal*")
;;   (end-of-buffer)
;;   (insert "echo hello")
;;   (term-send-input))


(defun python_run_main()
  (interactive)
  (let* ((src (file-name-nondirectory (buffer-file-name)))
         (exe (file-name-sans-extension src)))
    (evil-write-all nil)
    (+term/toggle "sthr")
    ;; (switch-to-buffer "doom:term-popup:main run")
    (end-of-buffer)
    (evil-normal-state)
    (insert " python main.py")
    (evil-insert-state)
    ;; (evil-normal-)
    ;; (term-send-string ("") "python")
    ;; (term-send-string (+term/toggle) "python")
    ;; (term-send-input )
    ;; (term-send-string (concat "python main.py"))
    ;; (+term/toggle )
    ))
