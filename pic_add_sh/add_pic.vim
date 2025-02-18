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



" Копирование (Перемещение) файлов в папку content: диапазон (визуальный режим)
function! ExportSelectedLines()
    let start = getpos("'<")[1]  " Начальная строка выделения
    let end = getpos("'>")[1]    " Конечная строка выделения
    let target_dir = getline(7)  " Папка назначения
    let target_note = getline(12) " Файл заметки для ссылок

    " Получаем все выделенные строки (файлы)
    let files = getline(start, end)

    " Перебираем каждый файл
    for filename in files
        let short_filename = fnamemodify(filename, ":t") " Только имя файла
        let timestamp = strftime("%Y%m%d%H%M") " Дата-время
        let new_filename = timestamp . "-" . short_filename " Новое имя"
        let new_filepath = target_dir . "/" . new_filename

        " Перемещаем файл
        let move_cmd = "mv " . shellescape(filename) . " " . shellescape(new_filepath)
        call system(move_cmd)

        " Добавляем ссылку в заметку
        let add_link = "echo -e '\n![[" . new_filename . "]]' >> " . shellescape(target_note)
        call system(add_link)
    endfor

    " Удаляю имена файлов картинок которые я переместил в хранилище
    normal! gvx
endfunction

vnoremap <leader>t :<C-u>call ExportSelectedLines()<CR><CR>
vnoremap бе :<C-u>call ExportSelectedLines()<CR><CR>

