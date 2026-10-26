import axios from "axios";
import { useState } from "react"
import { useNavigate } from "react-router-dom";

export default function AddTask() {

  let navigate = useNavigate()

  const [title,setTitle] =useState("");
  const [desc,setDesc] =useState("");

  async function AddTask(){
    const newTodo = {
      title:title,
      description:desc,
      completed:false
    }

    await axios.post("http://localhost:3000/todo",newTodo)
    navigate("/")
  }

  return (
    <div className="container">
        <h1 className="my-5 text-center ">Add Todo Task</h1>

        <div className="p-5 shadow border rounded rounded-5 w-75 mx-auto">

            <div className="my-2">
              <label htmlFor="title" className="form-label fw-bold">Title</label>
              <input type="text" id="title"  className="form-control" onChange={ (e)=> setTitle( e.target.value )}/>
            </div>

            <div className="my-2">
              <label htmlFor="desc" className="form-label fw-bold">Description</label>
              <input type="text" id="desc"  className="form-control" onChange={ (e)=> setDesc( e.target.value )}/>
            </div>

            <div className="my-4">
              <button className="btn btn-dark" onClick={()=>AddTask()}>Add Task</button>
            </div>

        </div>

    </div>
  )
}

