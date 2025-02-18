" Настройки для vim (перемещение картинок в хранилище)

" Удаляю маппинг для клавиши <leader>t
unmap <leader>t

" Копирование (Перемещение) файлов в папку content
function! ExportCurrentLine()
    let filename = getline(".")  " Получаем имя файла картинки из текущей строки
    let target_dir = getline(7)  " Получаю имя папки куда будет перемещена картинка
    let target_note = getline(12) " Имя заметки, в которую я буду добавлять ссылку

    " Получаем только имя файла без пути
    let short_filename = fnamemodify(filename, ":t")

    " Получаем текущую дату и время в нужном формате
    let timestamp = strftime("%Y%m%d%H%M")

    " Формируем новое имя файла
    let new_filename = timestamp . "-" . short_filename

    " Полный путь для нового файла
    let new_filepath = target_dir . "/" . new_filename

    " Создаю команду по перемещению файла с новым именем
    let move_cmd = "mv " . shellescape(filename) . " " . shellescape(new_filepath)
    
    " Добавляю ссылку в заметку Obsidian
    let add_link = "echo -e '\n![[" . new_filename . "]]' >> " . shellescape(target_note)

    call system(move_cmd)  " Переместить файл с новым именем
    call system(add_link)  " Добавить ссылку в заметку

    " Удаляем текущую строку с именем файла
    execute "normal! dd"
endfunction

nnoremap <leader>t :call ExportCurrentLine()<CR>
nnoremap бе :call ExportCurrentLine()<CR>

