;;; cpp2.el -*- lexical-binding: t; -*-
(defun er-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer-other-frame (other-buffer (current-buffer) 1)))

(defun runc()
  "Build and runc .cpp files"
  (interactive)
  (if (or (string= major-mode "c++-mode") (boundp 'file))
      (let ((a 10))
        (if (string= major-mode "c++-mode")
            (setq file (buffer-file-name (window-buffer (minibuffer-selected-window)))))
        (evil-write-all nil)

        (setq code-buf-default-directory default-directory)
        (if (boundp 'buf)
             (pop-to-buffer buf)
          (setq buf (+vterm/toggle nil)))
        (vterm-send-string (concat "cd " code-buf-default-directory "; ") )
        (vterm-send-string (concat "g++ '" file "' -o ~/dDg && echo 'Compiled.'; /usr/bin/time -f \"Executed in %esec. Used %KKB.\" ~/dDg; rm ~/dDg;") )
        (vterm-send-return)
        (with-current-buffer buf
          (evil-normal-state))
        (er-switch-to-previous-buffer))))

(map! :desc "Run c++ code" "<f9>" #'runc)
