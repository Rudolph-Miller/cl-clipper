(in-package :cl-user)
(defpackage clipper.format
  (:use :cl
        :clipper.config
        :clipper.database)
  (:export :*format-keys*))
(in-package :clipper.format)

(syntax:use-syntax :annot)

@export
(defvar *format-keys*
  (list :ID #'clip-id
        :URL #'clip-url
        :FILE-NAME #'clip-image-file-name-without-extension
        :EXTENSION #'clip-extension))

@export
(defun store-format (object)
  (loop with format = (clipper-config-format *clipper-config*)
        for (key fn) on *format-keys* by #'cddr
        do (setf format
                 (ppcre:regex-replace-all (format nil "~s" key)
                                          format
                                          (format nil "~a" (funcall fn object))))
        finally (return format)))

@export
(defgeneric retrieve-url (object type))
