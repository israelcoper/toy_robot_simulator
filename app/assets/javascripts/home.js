$(document).ready(() => {
    // assign selected commands to the hidden field
    $('.btn-command').on('click', e => {
        const value = $(e.target).val();
        const commandContainer = $('#command-container');
        const inputCommands = commandContainer.find('input#commands');

        commandContainer.removeClass('d-none');
        commandContainer.addClass('d-block');
        commandContainer.find('div').append(`<label class='me-2'>${value}</label>`);
        inputCommands.val(inputCommands.val() + value + ',');
    });

    // process the given commands
    $('form').on('submit', async e => {
        const latitude = $('#latitude option:selected').val();
        const longitude = $('#longitude option:selected').val();
        const direction = $('#direction option:selected').val();
        const commands = $('#commands').val();
        const data = { latitude, longitude, direction, commands };

        if (commands == "") {
            alert('Please select commands.');
        } else {
            $.ajax({
                url: '/report',
                method: 'POST',
                data,
                success: data => {
                    const commandContainer = $('#command-container');
                    
                    // reset form
                    $('#latitude').val('0');
                    $('#longitude').val('0');
                    $('#direction').val('NORTH');
                    commandContainer.find('input#commands').val('');
                    commandContainer.removeClass('d-block');
                    commandContainer.addClass('d-none');
                    commandContainer.find('div').html('');

                    // display input and output value
                    $('#inputValue').html(data.input);
                    $('#outputValue').html(data.output);
                },
                error: error => {
                    console.log(error);
                }
            });
        }

        e.preventDefault();
    });
});
