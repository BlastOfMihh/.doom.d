;;; cpp.el -*- lexical-binding: t; -*-

;; reddit code
(defun run-in-vterm-kill (process )
    ;; (process event)
  "A process sentinel. Kills PROCESS's buffer if it is live."
  (let ((b (process-buffer process)))
    (and (buffer-live-p b)
         (kill-buffer b))))

(defun run-in-vterm (command)
  "Execute string COMMAND in a new vterm.
Interactively, prompt for COMMAND with the current buffer's file
name supplied. When called from Dired, supply the name of the
file at point.

Like `async-shell-command`, but run in a vterm for full terminal features.

The new vterm buffer is named in the form `*foo bar.baz*`, the
command and its arguments in earmuffs.

When the command terminates, the shell remains open, but when the
shell exits, the buffer is killed."
  (interactive
   (list
    (let* ((f (cond (buffer-file-name) ((eq major-mode 'dired-mode) (dired-get-filename nil t))))
           (filename (concat " " (shell-quote-argument (and f (file-relative-name f))))))
      (read-shell-command "Terminal command: "
                          (cons filename 0)
                          (cons 'shell-command-history 1)
                          (list filename)))))
  (with-current-buffer (vterm (concat "*" command "*"))
    (set-process-sentinel vterm--process #'run-in-vterm-kill)
    (vterm-send-string command)
    (vterm-send-return)
    ;; (pop-to-buffer-same-window (vterm (concat "*" command "*")))
    ))

;; (defun insert-file-name ()
;;   "Insert the full path file name into the current buffer."
;;   (interactive)
;;   (insert (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(defun mihh (&optional buffer-name)
  "Create a new vterm.
If called with an argument BUFFER-NAME, the name of the new buffer will
be set to BUFFER-NAME, otherwise it will be `vterm'"
  (interactive)
  (setq prevb (window-buffer (minibuffer-selected-window)))
  ;; (setq file (buffer-file-name (window-buffer (minibuffer-selected-window))))

  (evil-write-all prevb)
  (if (string= major-mode "c++-mode")
      (setq file (buffer-file-name (window-buffer (minibuffer-selected-window)))))

  (if (get-buffer "vterm")
      () (vterm))

  (let ((buffer (get-buffer "vterm") ))
    (with-current-buffer buffer
      (text-scale-set 5)
      ;; (vterm-send-string (concat "g++ " file " -o dDg; if test -f 'dBg'; then ./dDg; rm dDg; echo; fi") )
      ;; (vterm-send-string (concat "g++ " file " -o dDg; ./dDg; rm dDg; echo;") )
      (vterm-send-string (concat "g++ " file " -o dDg && echo 'Compiled.'; /usr/bin/time -f \"Executed in %esec. Used %KKB.\" ./dDg; rm dDg;") )
      (vterm-send-return)
      (evil-normal-state)
      )
    (pop-to-buffer-same-window buffer))
  (switch-to-buffer-other-frame prevb)
  )
(map! ;; :leader
      :desc "Run c++ code"
      "<f9>" #'mihh)
