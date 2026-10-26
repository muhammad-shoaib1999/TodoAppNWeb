import axios from "axios";
import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

export default function UpdateTask() {
  let navigate = useNavigate();
  let { id } = useParams();

  const [title, setTitle] = useState("");
  const [desc, setDesc] = useState("");

  useEffect(() => {
    async function fetchTodoItem() {
      const todoItem = await axios.get(`https://todoappnweb.onrender.com/todo/${id}`);
      setTitle(todoItem.data.title);
      setDesc(todoItem.data.description);
    }
    fetchTodoItem();
  }, []);

  //   Update Api Call
  async function UpdateTask() {
    const newTodo = {
      title: title,
      description: desc,
    };

    await axios.put(`https://todoappnweb.onrender.com/todo/${id}`, newTodo);
    navigate("/");
  }

  return (
    <div className="container">
      <h1 className="my-5 text-center">Update Todo Task</h1>

      <div className="p-5 shadow border rounded rounded-5 w-75 mx-auto">

        <div className="my-3">
          <label htmlFor="title" className="form-label fw-bold">Title</label>
          <input type="text" id="title" value={title} className="form-control" onChange={(e) => setTitle(e.target.value)}/>
        </div>

        <div className="my-3">
          <label htmlFor="desc" className="form-label fw-bold">Description</label>
          <input type="text" id="desc" value={desc} className="form-control" onChange={(e) => setDesc(e.target.value)}/>
        </div>

        <div className="my-4">
          <button className="btn btn-warning" onClick={() => UpdateTask()}>Update Task</button>
        </div>

      </div>

    </div>
  );
}
