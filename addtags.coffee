template = '''
<div class="addtags-button-container">
    <button class="addtags-b"> bold </button>
    <button class="addtags-i"> italic </button>
    <button class="addtags-a"> link </button>
    <button class="addtags-blockquote"> blockquote </button>
    <button class="addtags-p"> paragraph </button>
</div>
'''

wrap = (textarea, tag, extra='') ->
    selection = textarea.value.substring(textarea.selectionStart, textarea.selectionEnd)
    wrapped = "<#{ tag + extra }>#{ selection }</#{ tag }>"
    before = textarea.value.substring 0, textarea.selectionStart
    after = textarea.value.substring textarea.selectionEnd, textarea.value.length
    textarea.value = before + wrapped + after


$ ->
    for textarea in $('textarea')
        $template = $(template)
        $(textarea).before $template
        for tag in ['b', 'i', 'a', 'blockquote', 'p']
            extra = if tag is 'a' then ' href=""' else ''
            do(textarea, $template, tag, extra) ->
                $template.find("button.addtags-#{ tag }").click ->
                    wrap(textarea, tag, extra)
                    false
