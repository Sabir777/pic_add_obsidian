" Настройки для vim: выбор файлов

" Удаляю маппинг для клавиши <leader>t
unmap <leader>t

" Функция для выбора заметки
nnoremap <leader>t :echo "Hello"

" При открытии файла перемещаю курсор в конец документа и центрирую его
augroup my_autocmds
    autocmd!
    autocmd VimEnter * normal! Gzz
augroup END

