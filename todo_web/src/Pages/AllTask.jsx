import axios from "axios";
import { useEffect, useState } from "react"
import { Link } from "react-router-dom";

export default function AllTask() {

  const [todo,setTodo] = useState([]);

  async function fetchTodoData(){
    const res =  await axios.get("http://localhost:3000/todo");
    setTodo(res.data)
  }

  useEffect(()=>{
    fetchTodoData()
  },[])

  async function handleStatus(id,status){
    if(status==true){
      await axios.put(`http://localhost:3000/todo/${id}`,{"completed":false})
      fetchTodoData()
    }else{
      await axios.put(`http://localhost:3000/todo/${id}`,{"completed":true})
      fetchTodoData()
    }
  }


  // Delete Api Call
  async function deleteTodo(id){
    await axios.delete(`http://localhost:3000/todo/${id}`)
    fetchTodoData()
  }

  return (
    <div className="container">

       <h1 className="mt-5">Todo Task</h1> 
       <div>
          {todo.map((item)=>(
               <div key={item._id} className={`p-3 shadow border border-2 rounded-5 d-flex justify-content-between my-3 ${item.completed?"border-success":"border-danger"}`}>
                 <div className="w-75 ">
                  <h4> {item.title}</h4> 
                  <p> {item.description}</p> 
                 </div>

                 

                 <div className="d-flex gap-3 w-25 justify-content-between">
                  
                  <div> 
                  {item.completed?
                    <button onClick={()=>handleStatus(item._id,item.completed)} className="badge text-bg-success btn">Complete</button>:
                    <button onClick={()=>handleStatus(item._id,item.completed)} className="badge text-bg-danger btn">Pending</button>
                  }
                  </div>
                  <div>
                    <Link to={`/edit/${item._id}`}>
                      <i className="bi bi-pencil-square text-warning fs-3"></i>
                    </Link>
                    <i className="bi bi-trash3 text-danger fs-3" role="button" onClick={()=>deleteTodo(item._id)}  ></i>
                  </div>
                 </div>
                </div>
            ))
          }
       </div>
    </div>
  )
}

