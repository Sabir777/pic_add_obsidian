" Настройки для vim: перемещение картинок в хранилище

" Удаляю маппинг для клавиши <leader>t
unmap <leader>t

" Копирование (Перемещение) файлов в папку content
function! ExportCurrentLine()
    let filename = getline(".")  " Получаем имя файла из текущей строки
    let target_dir = getline(7)  " Получаю имя папки куда будет перемещена картинка
    let target_note = getline(12) " Имя заметки в которую я буду добавлять ссылку на заметку

    " Получаем только имя файла без пути
    let short_filename = fnamemodify(filename, ":t")

    " Создаю команду по перемещению файла картинки в хранилище
    let move_cmd = "mv " . shellescape(filename) . " " . shellescape(target_dir)
    
    " Добавляю ссылку в заметку Obsidian
    let add_link = "echo -e '\n![[" . short_filename . "]]' >> " . shellescape(target_note)

    call system(move_cmd)  " Переместить файл
    call system(add_link)  " Добавить ссылку в заметку

    " Удаляем текущую строку с именем файла
    execute "normal! dd"
endfunction

nnoremap <leader>t :call ExportCurrentLine()<CR>
nnoremap бе :call ExportCurrentLine()<CR>

