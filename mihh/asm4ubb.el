;;; mihh/asm.el -*- lexical-binding: t; -*-

(map!
      ;; :after asm-mode
      :mode asm-mode
      :map asm-mode-map
      :leader
      :prefix "e"
      :desc "Compile and run NASM"
      "c" #'compileandrun_asm)

(defun compileandrun_asm()
  (interactive)
  (let* ((src (file-name-nondirectory (buffer-file-name)))
         (exe (file-name-sans-extension src))
         (alink " wine /home/mihh/Courses/ASC/asm_tools/nasm/ALINK.EXE ")
         (run_cmd (concat "nasm -fobj " src " -o " src ".obj;" alink src ".obj -oPE -subsys console -entry start -o "src ".exe ; wine " src ".exe"))
         (clean_cmd (concat "rm " src ".obj; rm " src ".exe"))
         )
    (compile (concat run_cmd ";" clean_cmd))))
    ;; (compile (concat alink src ".obj -oPE -subsys console -entry start -o "src ".exe ; wine /." src ".exe"))))

;; (defun compileandrun_g++()
;;   (interactive)
;;   (let* ((src (file-name-nondirectory (buffer-file-name)))
;;          (exe (file-name-sans-extension src)))
;;     (compile (concat "g++ " src " -o " exe " && timeout 1s ./" exe ))))

;; nasm -fobj module_name.asm
;; alink module_1.obj module_2.obj ...  module_n.obj -oPE -subsys console -entry start


(map! :leader
      :prefix ("e" . "debug")
      :desc "C/C++"
      "d" #'compileanddebug_asm)

(defun compileanddebug_asm()
  (interactive)
  (let* ((src (file-name-nondirectory (buffer-file-name)))
         (exe (file-name-sans-extension src))
         (alink " wine /home/mihh/Courses/ASC/asm_tools/nasm/ALINK.EXE ")
         (olly " wine /home/mihh/Courses/ASC/asm_tools/nasm/OLLYDBG.EXE ")
         (debug_cmd (concat "nasm -fobj " src " -o " src ".obj;" alink src ".obj -oPE -subsys console -entry start -o "src ".exe ; " olly src ".exe"))
         (clean_cmd (concat "rm " src ".obj; rm " src ".exe"))
         )
    (evil-write-all nil)
    (compile (concat debug_cmd ";" clean_cmd))))

;; (add-hook 'asm-mode-hook
;;           (lambda()
;;             (nasm-mode)))
