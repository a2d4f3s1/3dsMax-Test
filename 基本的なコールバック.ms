--MAXScriptでは、これにコールバックを使用できます。
--これは、特定のイベントに反応して、関数などの何かを実行するルーチンです。

--function that will print out selected object names:
--選択したオブジェクト名を出力する関数：
fn printSelName=
(
	for s in selection do print s.name
)--end fn
 
--add the callback that executes the function:
--関数を実行するコールバックを追加します。
callbacks.addScript #selectionSetChanged "printSelName()" id:#myCallbackID
 
--see if your callback has been registered:
--コールバックが登録されているかどうかを確認します。
callbacks.show()
 
--remove your callback by ID:
--IDでコールバックを削除します。
callbacks.removeScripts #selectionSetChanged id:#myCallbackID