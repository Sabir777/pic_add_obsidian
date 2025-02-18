" Настройки для vim (выбор заметки для редактирования)

" Удаляю маппинг для клавиши <leader>t
unmap <leader>t

" Сохранить имя заметки в файле
function! ExportCurrentLine()
    let line = getline(".")  " Получаем текущую строку
    let export_line = 'export NOTE="' . line . '"'  " Формируем строку
    call writefile([export_line], "export_file.vim", "w")  " Переписываю файл
    quit! " Закрываю vim
endfunction

nnoremap <leader>t :call ExportCurrentLine()<CR>
nnoremap бе :call ExportCurrentLine()<CR>

