" Настройки для vim (выбор папки-источника)

" Удаляю маппинг для клавиши <leader>t
unmap <leader>t

" Сохранить имя папки-источника в файле
function! ExportCurrentLine()
    let line = getline(".")  " Получаем текущую строку
    let export_line = 'export SOURCE_PIC="' . line . '"'  " Формируем строку
    call writefile([export_line], "export_file.vim", "a")  " Добавляю переменную в файл
    quit! " Закрываю vim
endfunction

nnoremap <leader>t :call ExportCurrentLine()<CR>
nnoremap бе :call ExportCurrentLine()<CR>

