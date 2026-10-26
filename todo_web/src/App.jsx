import { Route, Routes } from "react-router-dom"
import AddTask from "./Pages/AddTask"
import AllTask from "./Pages/AllTask"
import Header from "./Components/Header"
import UpdateTask from "./Pages/UpdateTask"

function App() {
  return (
    <div>
      
      <Header></Header>

      <Routes>
        <Route path="/"  element={<AllTask></AllTask>}/>
        <Route path="/add"  element={<AddTask></AddTask>}/>
        <Route path="/edit/:id"  element={<UpdateTask></UpdateTask>}/>
      </Routes>
    </div>
  )
}

export default App
