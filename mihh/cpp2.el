;;; cpp2.el -*- lexical-binding: t; -*-
(defun er-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer-other-frame (other-buffer (current-buffer) 1)))

(defun runc()
  "Build and runc .cpp files"
  (interactive)
      ;; (let ((file (buffer-file-name (window-buffer (minibuffer-selected-window)))))
  (if (or (string= major-mode "c++-mode") (boundp 'file))
      ;; (if (string= major-mode "c++-mode")
      (let ((a 10))
        (if (string= major-mode "c++-mode")
            (setq file (buffer-file-name (window-buffer (minibuffer-selected-window)))))
        (evil-write-all nil)

        (if (boundp 'buf)
            (pop-to-buffer buf)
          (setq buf (+vterm/toggle nil)))
        (with-current-buffer buf
          (text-scale-set 1.1)
          (vterm-send-string (concat "g++ " file " -o dDg && echo 'Compiled.'; /usr/bin/time -f \"Executed in %esec. Used %KKB.\" ./dDg; rm dDg;") )
          ;; (vterm-send-string (concat "\e[1;34mg++ " file " -o dDg && echo 'Compiled.'; /usr/bin/time -f \"Executed in %esec. Used %KKB.\" \e[0m ./dDg; rm dDg;") )
          ;; $ echo -e "\e[1;34mLight Blue Text\e[0m"
          (vterm-send-return)
          (evil-normal-state))
        (makunbound 'buf)
        (er-switch-to-previous-buffer))))

(map! :desc "Run c++ code" "<f9>" #'runc)

;; (defun runc()
;;   "Build and runc .cpp files"
;;   (interactive)
;;   (let ((file (buffer-file-name (window-buffer (minibuffer-selected-window)))))
;;     (evil-write-all nil)

;;     (if (boundp 'buf)
;;         (pop-to-buffer buf)
;;       (setq buf (+vterm/toggle nil)))
;;     (with-current-buffer buf
;;       (text-scale-set 1.1)
;;       (vterm-send-string (concat "g++ " file " -o dDg && echo 'Compiled.'; /usr/bin/time -f \"Executed in %esec. Used %KKB.\" ./dDg; rm dDg;") )
;;       (vterm-send-return)
;;       (evil-normal-state))
;;     (makunbound 'buf))
;;   (er-switch-to-previous-buffer))

;; (map! ;; :leader
;;       :desc "Run c++ code"
;;       "<f9>" #'runc)
